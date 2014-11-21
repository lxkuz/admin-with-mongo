class Admin::PicturesController < Admin::AdminController
  protect_from_forgery except: :create

  def destroy
    Picture.find(params[:id]).destroy
    request.xhr? ? render(text: true) : redirect_to(admin_pictures_path)
  end

  def create
    @picture = Picture.create file: params[:file]
    render json: { filelink: @picture.file.try(:url), filename: '', id: @picture._id }
  end

  def index
    res = Picture.where(target: nil).map do |p|
      { thumb: p.file.thumb('100x75#').url, image: p.file.try(:url), title: '', id: p._id }
    end
    render json: res
  end
end
