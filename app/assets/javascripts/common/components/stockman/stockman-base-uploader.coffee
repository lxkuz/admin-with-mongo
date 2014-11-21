guid = (->
  s4 = ->
    Math.floor((1 + Math.random()) * 0x10000).toString(16).substring 1
  ->
    s4() + s4() + "-" + s4() + "-" + s4() + "-" + s4() + "-" + s4() + s4() + s4())()

class window.StockmanImageUploader
  constructor: (el) ->
    @el = $ el
    @el.append(
      "<input multiple='multiple' type='file'>
            <div class='drag-n-drop'>
            <div>Перенесите изображения или нажмите</div>
            </div>
           <div class='gallery'></div>
            <div class='btn btn-danger delete-all'>Удалить</div>
            </div>"
    )
    @stockmanUrl = @el.data "stockman-url"
    @deleteAllBtn = $ ".delete-all", @el
    @hiddenField = $ "input[type='hidden']", @el
    @word = if @hiddenField.length > 0
      if @hiddenField.val()
        @hiddenField.val()
      else
        guid()
    else
      @el.data "word"
    @adminUrl = @stockmanUrl + "/" + @word
    @clientUrl = @stockmanUrl + "/" + CryptoJS.MD5(@word).toString()
    @img = $ "img", @el
    @dropBtn = $ ".drag-n-drop", @el
    @input = $ "input[type='file']", @el
    @overlay = $ ".overlay", @el
    @hiddenField.val @word if @hiddenField.length > 0

    @el.on "dragover", @dragover
    @el.on "dragenter", @dragenter

    @overlay.on "drop", @drop
    @overlay.on "dragleave", @dragleave

    @input.on "change", @upload
    @dropBtn.on "click", =>
      @input.click()
    @deleteAllBtn.on "click", @deleteAll

    @img.attr "src", @clientUrl
    _.defer =>
      @img.bind "error", @errorImageLoad
      @img.bind "load", @successImageLoad

  dragover: (ev) =>
    ev.preventDefault()

  dragenter: =>
    @el.addClass "can-drop"

  dragleave: =>
    @el.removeClass "can-drop"

  drop: (ev) =>
    ev.preventDefault()
    @el.removeClass "can-drop"
    @send ev.originalEvent.dataTransfer.files

  upload: =>
    @send @input[0].files

  send: (files) =>
    xhr = new XMLHttpRequest;
    xhr.open 'post', @adminUrl, true
    xhr.onload = @sendReady
    formData = new FormData
    formData.append "files[#{i}]", file for file, i in files
    xhr.send formData

  deleteAll: =>
    if confirm "Вы уверены в этом решении?"
      $.ajax
        url: @adminUrl + "/all"
        type: "DELETE"
        success: @sendReady
        error: =>
    false

  sendReady: =>
    src = @img.attr("src").split('?')[0]
    @img.attr "src", src + '?' + Math.random()

  successImageLoad: =>
    @img.show()
  errorImageLoad: =>
    @img.hide()
