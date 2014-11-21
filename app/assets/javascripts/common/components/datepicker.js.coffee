window.initializers = $.extend
  datepicker: (el) ->
    $(".datepicker-ui:not(.datepicker-ui-initialized)", el).each (i, container) ->
      $(container).datepicker
        changeMonth: true
        changeYear: true
        nextText: "→"
        prevText: "←"
        firstDay: 1

    .addClass "datepicker-ui-initialized"
  , window.initializers
