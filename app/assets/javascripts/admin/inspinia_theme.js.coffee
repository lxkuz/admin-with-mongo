
# Minimalize menu when screen is less than 768px
SmoothlyMenu = ->
  if not $("body").hasClass("mini-navbar") or $("body").hasClass("body-small")
    
    # Hide menu in order to smoothly turn on when maximize menu
    $("#side-menu").hide()
    
    # For smoothly turn on menu
    setTimeout (->
      $("#side-menu").fadeIn 100
      return
    ), 100
  else if $("body").hasClass("fixed-sidebar")
    $("#side-menu").hide()
    setTimeout (->
      $("#side-menu").fadeIn 100
      return
    ), 100
  else
    
    # Remove all inline style from jquery fadeIn function to reset menu state
    $("#side-menu").removeAttr "style"
  return

$(document).ready ->
  $('#side-menu').metisMenu()
  $('.navbar-minimalize').click ->
      $("body").toggleClass("mini-navbar")
      SmoothlyMenu()

$ ->
  $(window).bind "load resize", ->
    if $(this).width() < 769
      $("body").addClass "body-small"
    else
      $("body").removeClass "body-small"
    return

  return
