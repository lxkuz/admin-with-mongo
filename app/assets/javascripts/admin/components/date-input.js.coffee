class DateInput
  constructor: (el)->
    @el = $ el 
    @el.mask '99.99.9999'

window.addComponent DateInput, className: 'date-input'
