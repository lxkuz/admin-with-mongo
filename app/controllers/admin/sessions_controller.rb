class Admin::SessionsController < Devise::SessionsController

  private

  def set_locale
    I18n.locale = I18n.default_locale
  end
end
