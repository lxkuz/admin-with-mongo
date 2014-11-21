class MapDashboard
  constructor: (el)->
    @el = $ el 
    window.map = @el = L.map @el.get(0), 
      zoomControl: true
      attributionControl: false
      scrollWheelZoom: false
    L.tileLayer 'http://{s}.tile.osm.org/{z}/{x}/{y}.png', 
      maxZoom: 18
    .addTo(@el)
    @el.setView([54.793433, 87.021715], 7)
  
window.addComponent MapDashboard, className: 'map-dashboard'
