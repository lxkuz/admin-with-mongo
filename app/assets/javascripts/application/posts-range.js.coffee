class PostsRange
  constructor: (el)->
    @el = $ el
    @from = $ ".from", @el
    @to = $ ".to", @el
    @submit = $ ".btn-submit", @el
    @archive = $ ".archive a", @el
    @$target = $ @el.data('target')
    @$clear = $ @el.data('clear')
    @category = $ ".category select", @el
    
    @category.bind "change", @getData
    @$clear.bind "click", @clear
    @submit.bind "click", @getData
    @archive.bind "click", @getArchive

  getData: (ev) => 
    $.ajax
      url: @el.attr('action')
      data: @el.serialize()
      success: @updateTarget
      beforeSend: @loading

  getArchive: (ev) => 
    $.ajax
      url: @archive.data('url')
      success: @updateTarget
      beforeSend: @loading

  updateTarget: (data) =>
    @$target.removeClass "loading"
    @$target.html("")
    @$target.append(data)
    initialize @el

  loading: =>
    @$target.addClass "loading"

  clear: =>
    @from.val ''
    @to.val ''
    @category.val('').trigger("chosen:updated")
    @getData()

window.addComponent PostsRange, className: "posts-range"