class Admin::SettingsController < Admin::AdminController
  def create
    @settings.assign_attributes(settings_params)
    @settings.save
    respond_with(:admin, @settings, location: admin_settings_path)
  end

  def update
    @settings.update(settings_params)
    @settings.upsert
    respond_with(:admin, @settings, location: admin_settings_path)
  end

  private

  def settings_params
    params.require(:settings).permit(localized_permit(:title), localized_permit(:subtitle), :contact_email, :image, :image_uid, :image_name, :remove_image)
  end
end
