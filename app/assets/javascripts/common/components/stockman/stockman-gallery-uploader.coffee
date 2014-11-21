class StockmanGalleryUploader extends window.StockmanImageUploader
  constructor: (el) ->
    super
    @gallery = $ ".gallery", @el
    @sendReady()

  sendReady: =>
    $.ajax
      url: @clientUrl + "/all/x200"
      type: "GET"
      dataType: "json"
      success: @drawGallery
      error: =>

  drawGallery: (images) =>
    @gallery.empty()
    for imageUrl in images
      img = new StockmanGalleryImage imageUrl, @adminUrl, @clientUrl
      @gallery.append img.el

window.addComponent StockmanGalleryUploader, className: "stockman-uploader"


class StockmanGalleryImage
  constructor: (@url, @adminUrl, @clientUrl) ->
    uid = @url.split("/")[0] #TODO
    fullUrl = "#{@clientUrl}/#{@url}"
    @destroyUrl = "#{@adminUrl}/#{uid}"
    @el = $("<div>").addClass "s-gallery-image"
    @closeBtn = $("<div>").addClass "close-btn"
    @closeBtn.append $("<i>").addClass("fa fa-times-circle")
    @closeBtn.click @destroy
    @img = $("<img>").attr("src", fullUrl).addClass("thumbnail")
    @el.append @img
    @el.append @closeBtn

  destroy: =>
    $.ajax
      url: @destroyUrl
      type: "DELETE"
      success: @hide
    false

  hide: =>
    @el.fadeOut()