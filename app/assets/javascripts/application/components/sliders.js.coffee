# TODO с вопросом
# Слайдеры GallerySlider и MainPageSlider используются
# А вот ProjectsSlider вызывает у меня большие сомнения
# Мне кажется, его нужно убить // О.С.

class ProjectsSlider
  constructor: (el)->
    @el = $ el
    @slider = @el.slick
      centerPadding: "100px"
      centerMode: true
      dots: true
      touchMove: false
      slidesToShow: 5
      onAfterChange: @setNaP
      onInit: @setNaP
      responsive: [
        breakpoint: 1700
        settings: 
          slidesToShow: 3
          slidesToScroll: 1
          centerPadding: "150px"
      ,  
        breakpoint: 1500
        settings: 
          slidesToShow: 3
          slidesToScroll: 1
          centerPadding: "50px"
      ,
        breakpoint: 1300
        settings: 
          slidesToShow: 3
          slidesToScroll: 1
          centerPadding: "0px"    
      ,
        breakpoint: 1000
        settings: 
          slidesToShow: 1
          slidesToScroll: 1
          centerPadding: "0"
      ]
  setNaP: (obj) =>
    window.asdasd = obj
    $(".project").removeClass("previous-item")
    $(".project").removeClass("next-item")
    index = obj.getCurrent()
    current = $(".project[index='#{index}']", @el)
    current.prev().addClass("previous-item")
    current.next().addClass("next-item")
window.addComponent ProjectsSlider, className: "projects-slider"

class GallerySlider
  constructor: (el)->
    @el = $ el
    @slider = @el.slick
      infinite: false
      slidesToShow: 4 
      slidesToScroll: 1
      dots: true
      responsive: [
        breakpoint: 1250
        settings: 
          slidesToShow: 3
      ,  
        breakpoint: 1024
        settings: 
          slidesToShow: 2
      ,
        breakpoint: 800
        settings: 
          slidesToShow: 1
      ]
  
window.addComponent GallerySlider, className: "gallery-slider"

class MainPageSlider
  constructor: (el) ->
    @el = $ el
    @wrap = $ ".wrap", @el
    @setWidth()  
    @slider = @el.slick
      infinite: true
      slidesToShow: 1
      slidesToScroll: 1
      dots: true
      autoplay: true
      autoplaySpeed: 3000
    
    $(window).bind "load", @setHeight
    $(window).bind "resize", @setWidth

  setHeight: =>
    height = @el.parent().height()
    @wrap.css("height", height)
  
  setWidth: =>
    width = $(".second-line-block").width()* 0.666 - 10
    @el.css("width", width)    

window.addComponent MainPageSlider, className: "main-page-slider"
