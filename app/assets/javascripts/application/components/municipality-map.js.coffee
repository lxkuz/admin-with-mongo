class MunicipalityMap
  constructor: (el) ->
    @el = $ el
    @areas = $ "map area", @el
    console.log @areas
    for area in @areas
      $(area).bind "mouseover", @partOnHover
      $(area).bind "mouseout", @partOnOut

  partOnHover: (el) =>
    target = $(el.currentTarget)
    id = target.data("id")
    infoId = target.data("info-id")
    $(".object-data[data-id='0']", @el).hide()
    $(".object-data[data-id='#{infoId}']", @el).show()
    $(".map-image[data-image-id='#{id}']", @el).css "display", "inline"
  partOnOut: (el) =>
    $(".object-data", @el).hide()
    $(".object-data[data-id='0']", @el).show()
    $(".map-image", @el).css "display", "none"
      

window.addComponent MunicipalityMap, className: "municipality-map"