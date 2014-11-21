class RangeFilter
  constructor: (el)->
    @el = $ el
    @from = $ ".from", @el
    @to = $ ".to", @el
    @min = @from.data("value")
    @max = @to.data("value")

    @slider = $(".init", @el).ionRangeSlider
      min: @min
      max: @max
      from: @from.val()
      to: @to.val()
      type: 'double'
      prefix: "$"
      maxPostfix: "+"
      prettify: false
      hasGrid: false
      gridMargin: 6
      onChange: @setInput

  setInput: (slider) =>    
    @from.val(slider.fromNumber)
    @to.val(slider.toNumber)
    @to.trigger("change")
    @from.trigger("change")

  updateSlider: (ev) =>  
    target = $(ev.currentTarget)
    opts = {}
    opts[target.data("direction")] = target.val()
    @slider.ionRangeSlider "update", opts

window.addComponent RangeFilter, className: "range-filter"
