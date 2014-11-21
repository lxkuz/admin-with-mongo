class Admin::UsersController < Admin::AdminController
  before_action :set_user, only: [:edit, :update, :destroy]
  before_action :set_breadcrumbs, except: [:index, :destroy]
  include Scopable

  def index
    @users = apply_scopes(User).page params[:page]
    @breadcrumbs = [{ name: t('admin.breadcrumbs.root'), url: admin_dashboard_path }, { name: t('admin.users.index.title') }]
    respond_with @users
  end

  def new
    @user = User.new
    respond_with(:admin, @user)
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    @user.save
    respond_with(:admin, @user)
  end

  def update
    @user.update(user_params)
    respond_with(:admin, @user)
  end

  def destroy
    @user.destroy
    respond_with(:admin, @user)
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def set_breadcrumbs
    @breadcrumbs = [{ name: t('admin.breadcrumbs.root'), url: admin_dashboard_path }, { name: t('admin.users.index.title'), url: admin_users_path }, { name: t('.title') }]
  end

  def user_params
    pp = [:email]
    pp << [:password, :password_confirmation] unless params[:user][:password].blank?
    params.require(:user).permit pp
  end
end
