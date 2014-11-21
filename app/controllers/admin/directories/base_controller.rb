class Admin::Directories::BaseController < Admin::AdminController
  before_action :set_resource, only: [:edit, :update, :destroy]
  before_action :set_breadcrumbs, except: [:index, :destroy]
  helper_method :resource_class
  include Scopable

  def index
    @directories = apply_scopes(resource_class).page params[:page]
    respond_with(:admin, :directories, @directories)
  end

  def new
    @directory = resource_class.new
    respond_with(:admin, :directories, @directory)
  end

  def edit
  end

  def create
    @directory = resource_class.new(resource_params)
    @directory.save
    respond_with(:admin, :directories, @directory)
  end

  def update
    @directory.update(resource_params)
    respond_with(:admin, :directories, @directory)
  end

  def destroy
    @directory.destroy
    respond_with(:admin, :directories, @directory)
  end

  private

  def resource_class
    controller_name.classify.constantize
  end

  def set_resource
    @directory = resource_class.find(params[:id])
  end
end
