window.initialize = (el = document) ->
  func? el for key, func of window.initializers

ready =->
  initialize()

$(document).ready(ready)
$(document).on('page:load', ready)

window.addComponent = (klass, options = {}) ->
  throw "addComponent options must have className attribute" unless options.className 
  className = options.className 
  initializedClassName = "#{className}-initialized"
  disabledInitializeClassName = "disable-initializer"
  disabledCurrentInitializeClassName = "disable-#{className}"
  window.initializers ||= {}
  window.initializers[className] = (el) ->
    targets = $ ".#{className}:not(.#{initializedClassName}, .#{disabledInitializeClassName}, .#{disabledCurrentInitializeClassName})", el
    targets.each (i, target) ->
      item = new klass target
      $(target).addClass initializedClassName
      options.handler? item