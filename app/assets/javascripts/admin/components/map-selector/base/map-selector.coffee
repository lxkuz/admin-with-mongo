# This component can read either 'string coded coordinates' or geojson
# and encode it as geojson in coordinates field

class window.MapSelector
  constructor: (el, options) ->
    el = $ el
    options = _.extend options,
      coordsSelector: 'coords'
      mapContainerId: 'map-container'

    @coordsField = $ "input[name='#{options.namespace}[#{options.coordsSelector}]']", el
    coords = @coordsField.val()

    map = @initializeMap el, options
    drawItems = @initializeDrawItems map, coords

    map.addLayer drawItems
    map.fitBounds drawItems.getBounds() unless _(drawItems.getLayers()).isEmpty()

    drawControl = @initializeDrawControl map, drawItems

  # Options

  drawControlOptions: (drawItems) =>
    draw:
      position: 'topleft'
      circle:     false
      marker:     false
      polygon:    false
      polyline:   false
      rectangle:  false
    edit:
      edit:
        title: 'Редактировать'
      featureGroup: drawItems
      remove:
        title: 'Очистить'

  # Initializers

  initializeMap: (el, options) =>
    L.Icon.Default.imagePath = '/images/'
    
    map = L.map $('#map-container', el).get(0),
      zoomControl: false
      attributionControl: false

    map.setView options.setViewCoords, 9
    L.tileLayer(options.tileServerPath, tms: options.tms).addTo map

    map

  initializeDrawItems: (map, coords, options = {}) =>
    drawItems = @createLayer coords

  initializeDrawControl: (map, drawItems, options = {}) =>
    options = @drawControlOptions drawItems
    drawControl = new L.Control.Draw options
    map.addControl drawControl

    map.on 'draw:created',   (event) => @onCreated    event, drawItems
    map.on 'draw:edited',    (event) => @onEdited     event, drawItems
    map.on 'draw:drawstart', (event) => @onDrawstart  event, drawItems
    map.on 'draw:deleted',   (event) => @onDeleted    event, drawItems

    drawControl

  # Event handlers

  onCreated: (event, drawItems) =>
    layer = event.layer
    drawItems.addLayer layer
    @saveLayer drawItems

  onEdited: (event, drawItems) =>
    @saveLayer drawItems

  onDrawstart: (event, drawItems) =>
    drawItems.clearLayers()

  onDeleted: (event, drawItems) =>
    @coordsField.val ''

  # Layer handlers

  createLayer: (coords) =>
    if coords then @parse coords else new L.FeatureGroup()

  createStringEncodedLayer: (coords) =>
    false

  saveLayer: (layer) =>
    @coordsField.val JSON.stringify layer.toGeoJSON()
    layer

  # Parsers

  # returns GeoJson layer or new FeatureGroup or
  # FeatureGroup with layer whose coordinates were decoded from string
  parse: (coords) =>
    try
      drawItems = @parseGeoJson coords
      return drawItems

    catch error
      console.error error.message
      console.info """I can not parse GeoJSON, probably there are string encoded coordinates.
                      Falling back to string encoded coordinates."""

      drawItems = @parseStringEncoded coords
      return drawItems

  parseGeoJson: (coords) =>
    data = JSON.parse coords
    drawItems = L.geoJson data

  parseStringEncoded: (coords) =>
    layer = @createStringEncodedLayer coords
    drawItems = new L.FeatureGroup()
    drawItems.addLayer layer if layer
    drawItems

  parsePoint: (coords) =>
    coords = coords.split '_'
    [parseFloat(coords[0]), parseFloat(coords[1])]

  parsePolyline: (coords) =>
    if coords and coords.length > 1
      coords = coords.split '_'
      if coords
        coordsX = coords[0].split ','
        coordsY = coords[1].split ','
        if coordsX.length > 0 and coordsY.length > 0
          lngs = _(coordsX).map (lng) -> parseFloat lng
          lats = _(coordsY).map (lat) -> parseFloat lat
          _.zip lngs, lats
    else
      [[0, 0]]

  parsePolygon: (coords) =>
    @parsePolyline coords
