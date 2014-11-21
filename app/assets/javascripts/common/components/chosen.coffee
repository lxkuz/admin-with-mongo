window.initializers.chosen = (el)->
    $(".simple-chosen:not(.simple-chosen-initialized)", el).each (i, input) ->
      $(input).chosen allow_single_deselect: true
    .addClass "simple-chosen-initialized"
