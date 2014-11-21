$ ->
  $.ajaxSetup
    headers:
      'X-CSRF-Token': $('meta[name="csrf-token"]').attr 'content'

class MenuTree
  constructor: (el)->
    @el = el
    @rootId = @el.data "root"

    $.ajax
      type: "GET"
      dataType: "json"
      url: "sections"
      cache: false

    @renderTree()

  renderTree: =>
    oldTree = @el.children()
    container = $("<div>").data("url", @urlFor("section", {method: "index", format: "json"}))
    container.hide().appendTo @el
    @tree = container.tree
      dragAndDrop: yes
      saveState: "menu-tree"
      selectable: no
      onCreateLi: @initLiItem
      useContextMenu: no
      onCanMoveTo: @onlyIntoSection
    @tree.bind "tree.move", @moveItem
    @tree.bind "tree.init", =>
      oldTree.remove()
      container.show()

  onlyIntoSection: (moved_node, target_node, position)=>
    if position == "inside"
      targetKind = target_node.attributes.kind
      return no if targetKind != "section"
    yes

  moveItem: (event)=>
    setTimeout =>
      # этот settimeout необходим для того, чтобы в поле moved_node.parent прописался новый парент
      newParent = event.move_info.moved_node.parent
      prevParent = event.move_info.previous_parent
      @updateChildren newParent, =>
        if prevParent.id != newParent.id
          @updateChildren prevParent
    , 0

  updateChildren: (node ={}, successCallback)=>
    child_ids = for child in node.children
      child.id
    data = {}
    data.child_ids = _.compact child_ids
    data.parent_id = node.id
    $.ajax
      type: "PUT"
      dataType: "json"
      url: @urlFor("section", method: "move")
      data: data
      error: alert
      success: successCallback

  urlFor: (node, options = {})=>
    if _.isString(node)
      word = node
    else
      word = _.str.dasherize _.str.underscored(node.type)
    base = @el.data "url-#{word}"
    res = switch options.method
      when "index" then base
      when "edit" then "#{base}/#{node.id}/edit"
      when "new" then "#{base}/new"
      when "move" then "#{base}/move"
      when 'show' then "/#{word}s/#{node.id}"
      else "#{base}/#{node.id}"
    res += ".#{options.format}" if options.format
    if options.params
      paramsArr = for key, value of options.params
        "#{key}=#{value}"
      res += "?#{paramsArr.join("&")}"
    res

  destroyItem: (node)=>
    if confirm(t("messages.destroy_confirm"))
      $.ajax
        type: "DELETE"
        dataType: "json"
        url: @urlFor(node)
        success: @renderTree

  getTemplateFunc: (name) =>
    name = _.str.dasherize _.str.underscored(name)
    window.JST["templates/#{name}-menu-item"]

  initLiItem: (node, $li) =>
    template = @getTemplateFunc node.type
    $li.attr("node-id", node.id)
    title = $ ".jqtree-title", $li
    disabled = node.children.length > 0
    published = node.attributes.published
    kind = node.attributes.kind

    title.html(template
      urlFor: @urlFor
      node: node
      name: title.html()
      destroyDisabled: disabled
      published: published
      kind: kind)

    destroyBtn = $ "a.destroy-btn", title
    destroyBtn.click (ev)=>
      target = $(ev.currentTarget)
      @destroyItem node unless target.attr "disabled"

$ ->
  el = $ ".menu-tree-container"
  new MenuTree el if el.length > 0