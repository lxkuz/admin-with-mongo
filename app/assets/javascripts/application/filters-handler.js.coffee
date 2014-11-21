class FiltersHandler
  constructor: (el)->
    @el = $ el
    @inputs = $ "input", @el
    @$target = $ @el.data('target')
    @from = $ ".from", @el
    @to = $ ".to", @el
    @clearWrapper = $ ".clear-filters-wrapper", @el
    @getData = _.debounce(@getData, 300)
    @inputs.bind "change", @getData
    @inputs.bind "change", @clearBtnShow

  getData: =>
    $.ajax
      url: @el.attr('action')
      data: @el.serialize()
      success: @updateTarget
      beforeSend: @loading

  updateTarget: (data) =>
    @$target.removeClass "loading"
    @$target.html("")
    @$target.append(data)

  clearBtnShow: =>
    @clearWrapper.show()

  loading: =>
    @$target.addClass "loading"
    
window.addComponent FiltersHandler, className: "filters-handler"