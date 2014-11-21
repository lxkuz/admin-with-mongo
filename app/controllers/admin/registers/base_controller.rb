class Admin::Registers::BaseController < Admin::AdminController
  before_action :set_resource, only: [:edit, :update, :destroy]
  before_action :set_breadcrumbs, except: [:index, :destroy]
  helper_method :resource_class
  include Scopable

  def index
    @collection = apply_scopes(resource_class).page params[:page]
    respond_with(:admin, :registers, @collection)
  end

  def new
    @resource = resource_class.new
    respond_with(:admin, :registers, @resource)
  end

  def edit
  end

  def create
    @resource = resource_class.new(resource_params)
    @resource.save
    respond_with(:admin, :registers, @resource)
  end

  def update
    @resource.update(resource_params)
    respond_with(:admin, :registers, @resource)
  end

  def destroy
    @resource.destroy
    respond_with(:admin, :registers, @resource)
  end

  private

  def resource_class
    controller_name.classify.constantize
  end

  def set_resource
    @resource = resource_class.find(params[:id])
  end
end
