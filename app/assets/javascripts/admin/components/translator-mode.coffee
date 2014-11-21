class TranslatorMode
  constructor: (el) ->
    @el = $ el
    @el.bind "click", @toggle
    @opened = if $.cookie("localized-state-opened")
      JSON.parse($.cookie("localized-state-opened"))
    else
      false

    if @opened
      @turnOn silent: true
    else
      @turnOff silent: true

  toggle: =>
    if @opened
      @turnOff()
    else
      @turnOn()

  turnOn: (opts = {}) =>
    @opened = yes unless opts.silent
    $.cookie("localized-state-opened", @opened, {path: '/'})
    $("body").addClass "translate-on"
    $(window).trigger "set-translate"

  turnOff: (opts = {}) =>
    @opened = no unless opts.silent
    $("body").removeClass "translate-on"
    $.cookie "localized-state-opened", @opened, {path: '/'}

window.addComponent TranslatorMode, className: "translator-mode"




