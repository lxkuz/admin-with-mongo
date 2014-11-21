class Admin::PagesController < Admin::AdminController
  before_action :set_page, only: [:edit, :update, :destroy]
  before_action :set_breadcrumbs, except: [:index, :destroy]

  def new
    @page = Page.new parent_id: params[:parent_id]
    respond_with(:admin, @page)
  end

  def edit
  end

  def create
    @page = Page.new(page_params)
    @page.save
    respond_with(:admin, @page, location: admin_sections_path)
  end

  def update
    @page.update(page_params)
    respond_with(:admin, @page, location: admin_sections_path)
  end

  def destroy
    @page.destroy
    render json: true
  end

  private

  def set_page
    @page = Page.find(params[:id])
  end

  def set_breadcrumbs
    @breadcrumbs = [{ name: t('admin.breadcrumbs.root'), url: admin_dashboard_path }, { name: t('admin.sections.index.title'), url: admin_sections_url }, { name: t('.title') }]
  end

  def page_params
    params.require(:page).permit(localized_permit(:title),
                                 :section_id,
                                 localized_permit(:content),
                                 localized_permit(:intro),
                                 :published,
                                 :css_class,
                                 :parent_id)
  end
end
