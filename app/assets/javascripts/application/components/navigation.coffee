class Navigation
  constructor: (el) ->
    @el = $ el
    @items = @el.find("> li")
    new NavItem item for item in @items
    @showActiveSubitem()

  showActiveSubitem: =>
    activeSubLi = $("li li.active", @el)
    if activeSubLi.length > 0
      activeSubLi.parents("li").addClass "opened active"

class NavItem
  constructor: (el) ->
    @el = $ el
    @children = $ "ul.nav-second-level", @el
    @el.click @toggleChildren if @children.length > 0

  toggleChildren: (ev) =>
    return if @children[0] in $(ev.target).parents()
    @el.toggleClass "opened active"
    false






window.addComponent Navigation, className: "navigation"