class RadioSelectors
  constructor: (el) ->
    @el = $ el
    @selectors = $ "select", @el
    @options = _.clone(@selectors.first().children())
    @selectors.change @radio
    for select in @selectors
      $(select).trigger "change"

  radio: (ev)=>
    current = ev.currentTarget
    value = $(current).val()
    for obj in @selectors
      if obj != current
        options = $ "option", obj
        options.removeAttr 'disabled'

        option = $ "option[value='#{value}']", obj
        option.attr 'disabled','disabled'

window.addComponent RadioSelectors, className: "radio-selectors"




