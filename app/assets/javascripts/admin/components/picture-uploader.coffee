class window.PictureUploader
  constructor: (el) ->
    @el = $ el
    @addElBtn = $(".add-upload-picture", @el)
    @destroyElBtn = $(".destroy-upload-picture", @el)
    @template = $('.upload-picture-template', @el).hide()
    @textarea = $ @el.data('textarea')

    @destroyElBtn.bind "click", @destroyElement
    @addElBtn.bind "click", @addElement

    unless @textarea.length is 0
      $(".element", @el).each @bindPictureInsert
    else
      $('.insert-el-link', @el).hide()
    @el.bind "submit", @removeTemplate

  removeTemplate: ->
    @template.remove()

  addElement: =>
    attachment = @template.clone().insertAfter(@template).removeClass("template").show()

    $(".destroy-upload-picture", attachment).bind "click", ->
      attachment.remove()
      no
    $("input", attachment).attr "name", (index, attr) ->
      attr.replace /\[[0-9-a-z]*\]$/, "[" + $.Guid.New() + "]"
    no

  destroyElement: (e) ->
    target = $ e.currentTarget
    href = target.attr 'href'
    parent = target.parent().parent()
    $.ajax
      url: href,
      type: 'DELETE',
      success: ->
        parent.fadeOut 'slow', ->
          parent.remove()
    no

  bindPictureInsert: (i, el) =>
    insertLink = $ ".insert-el-link", el
    picture = $ "img", el
    insertLink.bind 'click', =>
      @textarea.insertAtCaret "<img src='http://" + window.location.host + picture.data("url") + "'>"


window.addComponent PictureUploader, className: "uploader-picture"