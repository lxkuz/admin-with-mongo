class Admin::PageFragmentsController < Admin::AdminController
  before_action :set_page_fragment, only: [:edit, :update]
  before_action :set_breadcrumbs, except: [:index]

  def index
    @page_fragments = PageFragment.visible.page params[:page]
    @breadcrumbs = [{ name: t('admin.breadcrumbs.root'), url: admin_dashboard_path }, { name: t('admin.page_fragments.index.title') }]
    respond_with(@page_fragments)
  end

  def edit
  end

  def update
    @page_fragment.update page_fragment_params
    respond_with(:admin, @page_fragment)
  end

  private

  def page_fragment_params
    params.require(:page_fragment).permit(localized_permit(:content))
  end

  def set_page_fragment
    @page_fragment = PageFragment.visible.find params[:id]
  end

  def set_breadcrumbs
    @breadcrumbs = [{ name: t('admin.breadcrumbs.root'), url: admin_dashboard_path }, { name: t('admin.page_fragments.index.title'), url: admin_page_fragments_path }, { name: t('.title') }]
  end
end
