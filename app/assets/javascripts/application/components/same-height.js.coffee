# данную проблему решили на уровне css
#
# class SameHeight
#   constructor: (el)->
#     @el = $ el 
#     @blocks = $ ".watch-height", @el
#     $(window).bind "load", @calculate
#   calculate: =>
#     @maxHeight = 0
#     for block in @blocks
#       height = $(block).height()
#       @maxHeight =  height if height > @maxHeight
#     _.defer =>
#       for block in @blocks
#         $(block).css("height", @maxHeight)     
#         $(block).addClass("calculated")

# window.addComponent SameHeight, className: 'same-height'
