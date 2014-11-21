class MapViewer
  constructor: (el) ->
    @el = $ el
    config =
      tileServerPath: 'http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png'
      tms: false
    L.Icon.Default.imagePath = '/images/'
    map = L.map @el.get(0),
      zoomControl: false
      attributionControl: false
    L.tileLayer(config.tileServerPath, tms: config.tms).addTo map
    coords = L.geoJson( @el.data "coords")
    bounds = coords.getBounds()
    coords.addTo map
    map.fitBounds bounds
    map

window.addComponent MapViewer, className: "map-viewer"

