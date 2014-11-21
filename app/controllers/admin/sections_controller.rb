class Admin::SectionsController < Admin::AdminController
  before_action :set_section, only: [:edit, :update, :destroy]
  before_action :set_breadcrumbs, except: [:index, :destroy]
  before_action :set_section_kind, only: [:new]

  def index
    @sections = apply_scopes(Section).page params[:page]
    @breadcrumbs = [{name: t('admin.breadcrumbs.root'), url: admin_dashboard_path}, {name: t('admin.sections.index.title')}]
    respond_with(@sections) do |format|
      format.json { render json: Section.root.children.map(&:export) }
    end
  end

  def new
    @parent_id = params[:parent_id]
    @section = Section.new kind: @kind
    respond_with(:admin, @section)
  end

  def edit
  end

  def create
    @section = Section.new section_params
    @section.save
    respond_with(:admin, @section)
  end

  def update
    @section.update section_params
    respond_with(:admin, @section)
  end

  def move
    target = if params[:parent_id]
               Section.find params[:parent_id]
             else
               Section.root
             end
    target.child_ids = params[:child_ids] || []
    target.save
    render text: true
  end

  def destroy
    @section.destroy
    render json: true
  end

  private

  def set_section_kind
    @kind = if params[:reference]
             "reference"
           else
             "section"
           end
  end

  def set_section
    @section = Section.find(params[:id])
  end

  def set_breadcrumbs
    @breadcrumbs = [{name: t('admin.breadcrumbs.root'), url: admin_dashboard_path}, {name: t('admin.sections.index.title'), url: admin_sections_url}, {name: t('.title')}]
  end

  def section_params
    params.require(:section).permit localized_permit(:title),
                                    localized_permit(:intro),
                                    :parent_id,
                                    :key,
                                    :url,
                                    :kind,
                                    :breadcrumbs,
                                    :description,
                                    :published,
                                    :css_class
  end
end
