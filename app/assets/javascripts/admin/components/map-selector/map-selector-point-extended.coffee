# Extended point map selector
# Deals with custom coordinates and address
class window.MapSelectorPointExtended extends MapSelectorPoint
  constructor: (el, options) ->
    @customCoordX = $ '#coordX', @el
    @customCoordY = $ '#coordY', @el

    @customCoordXdeg = $ '#coordXdeg', @el
    @customCoordYdeg = $ '#coordYdeg', @el

    @addressesList = $ '#address-autocomplete', @el
    @addressClearButton = $ '#address-clear-button', @el
    @addressClearButton.on 'click', @clearAddressInput
    super

  # Initializers

  initializeDrawItems: (map, coords, options = {}) =>
    drawItems = super

    customCoordButton = $ '#customCoordsUpdate', @el
    customCoordButton.on 'click', (event) => @updateCustomCoords event, map, drawItems

    customCoordDegButton = $ '#customCoordsDegUpdate', @el
    customCoordDegButton.on 'click', (event) => @updateCustomDegCoords event, map, drawItems

    @addressInput = $ '#address', @el
    @addressInput.on 'keyup', (event) => @onAddressInputKeyup event, map, drawItems

    drawItems

  # Layer handlers

  saveLayer: (layer) =>
    drawItems = super

    latlng = _(drawItems.getLayers()).first().getLatLng()
    @setCustomCoords [latlng.lat, latlng.lng]

    drawItems

  updateDrawItems: (map, drawItems, coords) =>
    point = new L.marker coords, icon: @icon
    drawItems.clearLayers()
    drawItems.addLayer point
    map.fitBounds drawItems.getBounds(), maxZoom: 16 unless _(drawItems.getLayers()).isEmpty()

    @saveLayer drawItems
    drawItems

  updateCustomCoords: (event, map, drawItems) =>
    lat = @customCoordX.val()
    lng = @customCoordY.val()

    dms = @ddtodms lat
    dms = @ddtodms lng

    @customCoordXdeg.val dms.join ' '
    @customCoordYdeg.val dms.join ' '

    @updateDrawItems map, drawItems, [parseFloat(lat), parseFloat(lng)]

  updateCustomDegCoords: (event, map, drawItems) =>
    lats = @customCoordXdeg.val().split ' '
    lons = @customCoordYdeg.val().split ' '

    lat = @dmstodd lats[0], lats[1], lats[2]
    lng = @dmstodd lons[0], lons[1], lons[2]

    @customCoordX.val lat
    @customCoordY.val lng

    @updateDrawItems map, drawItems, [lng, lat]

  # Address input handlers

  onAddressInputKeyup: (event, map, drawItems) =>
    if @sending
      @again = yes
      return

    address = @addressInput.val()
    if address
      @addressesList.show()
      @addressClearButton.show()
      $.ajax
        url: 'http://geocode-maps.yandex.ru/1.x/?format=json&geocode=' + address

        success: (data) =>
          features = data.response.GeoObjectCollection.featureMember
          @refreshList map, drawItems, _(features).map (feature) ->
            [feature.GeoObject.metaDataProperty.GeocoderMetaData.text,
            feature.GeoObject.Point.pos]

        complete: =>
          @sending = no
          @onAddressInputKeyup() if @again
    else
      @addressClearButton.hide()
      @addressesList.hide()
      @addressesList.html ''

  clearAddressInput: (event) =>
    @addressInput.val ''
    @addressClearButton.hide()
    @addressesList.hide()
    @addressesList.html ''

  refreshList: (map, drawItems, items) =>
    @addressesList.html ''
    _(items).each ([name, point]) => @addressesList.append "<li data-point='#{point}' data-name='#{name}'>#{name}</li>"
    $('li', @addressesList).on 'click', (event) => @selectListItem event, map, drawItems

  selectListItem: (event, map, drawItems) =>
    target = $ event.currentTarget

    name = target.data 'name'
    point = target.data 'point'

    @addressInput.val name
    @addressesList.hide()
    @addressesList.html ''

    [lng, lat] = point.split ' '
    @updateDrawItems map, drawItems, [lat, lng]

  # Parsers

  parseGeoJson: (coords) =>
    drawItems = super

    latlng = _(drawItems.getLayers()).first().getLatLng()
    @setCustomCoords [latlng.lat, latlng.lng]

    drawItems

  parseStringEncoded: (coords) =>
    @setCustomCoords @coordsField.val().split '_'
    super

  setCustomCoords: ([lat, lng]) =>
    dms = @ddtodms lat
    dms = @ddtodms lng

    @customCoordX.val lat
    @customCoordY.val lng

    @customCoordXdeg.val dms.join ' '
    @customCoordYdeg.val dms.join ' '

  # Helpers

  dmstodd: (d, m, s) =>
    parseFloat(d) + parseFloat(m/60) + parseFloat(s/3600)

  ddtodms: (dd) =>
    d = parseFloat(parseFloat(dd).toFixed(0))
    m = parseFloat ((dd * 60) % 60).toFixed(0)
    s = parseFloat ((dd * 3600) % 60)
    [d, m, s]