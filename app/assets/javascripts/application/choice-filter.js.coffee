class ChoiceFilter
  constructor: (el)->
    @el = $ el
    @opened = no
    @expandBtn = $ ".expand-button", @el
    @checkboxes = $ ".scroll-container input", @el
    
    @expandBtn.bind "click", @toogle
    @checkboxes.bind "change", @onChange
    @selected = $ ".selected-items", @el
    @drawSelected()

  
  toogle: =>
    if @opened
      @opened = no
      @close() 
    else
      @opened = yes
      @open()

  open: =>
    @el.addClass "opened"

  close: =>  
    @el.removeClass "opened"

  onChange: (ev) =>
    target = $(ev.currentTarget)
    parent = target.parent("li")
    if target.prop("checked")  
      cloned = parent.clone()
      $("input", cloned).remove()
      cloned.appendTo @selected
    else
      selected = $("li[data-id='#{parent.data('id')}']", @selected)  
      selected.remove() 
#    @checkSelected()

  checkSelected: =>
    if $("li", @selected).size() > 0
      @el.addClass "with-selected"
    else
      @el.removeClass "with-selected"  

  drawSelected: =>
    @checked = $ ".scroll-container input:checked", @el
    for item in @checked
      parent = $(item).parent("li")
      cloned = parent.clone()
      $("input", cloned).remove()
      cloned.appendTo @selected
      @checkSelected()

window.addComponent ChoiceFilter, className: "choice-filter"