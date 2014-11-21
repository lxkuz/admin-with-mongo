# Base point map selector
class window.MapSelectorPoint extends MapSelector
  constructor: (el, options) ->
    @icon = new L.Icon
      shadowUrl: null
      iconSize: new L.Point 25, 41
      iconAnchor: new L.Point 12.5, 41
      iconUrl: '/assets/marker-icon.png'

    super

  drawControlOptions: () =>
    options = super
    options.draw = _.extend options.draw, marker: icon: @icon
    _.extend options, edit: false

  createStringEncodedLayer: (coords) =>
    point = new L.marker @parsePoint(coords), icon: @icon