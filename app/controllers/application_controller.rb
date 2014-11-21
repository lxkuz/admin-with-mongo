class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  layout proc { devise_controller? ? 'devise' : 'application' }
  before_action { @settings ||= Settings.instance }
  before_action :set_locale
  respond_to :html

  private

  def default_url_options(*)
    { locale: I18n.locale }
  end

  def set_locale
    locale = params[:locale] || session[:locale] || I18n.default_locale
    session[:locale] = locale
    I18n.locale = locale
  end

  def routing_error
    fail ActionController::RoutingError, "No route matches [#{request.env['REQUEST_METHOD']}] #{request.env['PATH_INFO']}"
  end
end
