class window.MapSelectorPolygon extends MapSelector
  drawControlOptions: () =>
    options = super
    options.draw = _.extend options.draw,
      polygon:
        title: 'Нарисовать область'
        allowIntersection: false
        drawError:
          color: '#b00b00'
          timeout: 1000
          message: 'Линии не могут пересекаться'
        shapeOptions:
          color: '#03F'

    options

  createStringEncodedLayer: (coords) =>
    polygon = new L.Polygon @parsePolygon coords