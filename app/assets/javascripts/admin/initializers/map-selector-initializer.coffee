window.initializers = _.extend
  mapSelector: (el) ->
    config =
      setViewCoords: [55.354167, 86.089722]
      tileServerPath: 'http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png'
      tms: false
    $('.map-selector:not(.map-selector-initialized)', el).each (i, target) ->
      element = $(target)
      type = element.data 'map-selector'
      namespace = element.data 'namespace'
      options = _.extend config,
        type: type
        coordsSelector: element.data 'coords-field'
      options.namespace = namespace if namespace
      initMap = (type) ->
        switch type
          when 'area'           then  new MapSelectorPolygon        target, options
          when 'line'           then  new MapSelectorPolyline       target, options
          when 'point'          then  new MapSelectorPoint          target, options
          when 'point-extended' then  new MapSelectorPointExtended  target, options
          else                        new MapSelectorPoint          target, options
      initMap type
      $mapTypeSelect = $ '.map-type-select'
      $mapTypeSelect.bind 'change', ->
        mapSelectorType = $('option:selected', $mapTypeSelect).attr 'map-type'
        $('#map-container').replaceWith $('<div>', id: 'map-container')
        initMap mapSelectorType
    .addClass 'map-selector-initialized'
, window.initializers
