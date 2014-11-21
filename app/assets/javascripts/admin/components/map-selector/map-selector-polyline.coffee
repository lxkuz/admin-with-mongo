class window.MapSelectorPolyline extends MapSelector
  
  drawControlOptions: () =>
    options = super
    options.draw = _.extend options.draw,
      polyline:
        title: 'Нарисовать линию'
        allowIntersection: true
        drawError:
          color: '#b00b00'
          timeout: 1000
          message: 'Линии не могут пересекаться'
        shapeOptions:
          color: '#03F'

    options

  createStringEncodedLayer: (coords) =>
    polyline = new L.Polyline @parsePolyline coords