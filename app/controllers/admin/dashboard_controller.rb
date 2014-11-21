class Admin::DashboardController < Admin::AdminController
  before_action :set_breadcrumbs, only: :index

  private

  def set_breadcrumbs
    @breadcrumbs = [{ name: t('breadcrumbs.admin.root') }]
  end
end
