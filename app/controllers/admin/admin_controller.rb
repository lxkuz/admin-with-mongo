class Admin::AdminController < ApplicationController
  before_action :authenticate_user!
  layout 'admin'
  responders :flash, :http_cache, :collection

  private

  def set_locale
    I18n.locale = I18n.default_locale
  end

  def localized_permit(param)
    obj = {}
    key = "#{param}_translations".to_sym
    obj[key] = I18n.available_locales
    obj
  end

  def image_permit(param)
    [
      param.to_sym, "#{param}_uid".to_sym,
      "#{param}_name".to_sym,
      "remove_#{param}".to_sym,
      "retained_#{param}".to_sym
    ]
  end
end
