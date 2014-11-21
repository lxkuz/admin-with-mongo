class Page
  include Mongoid::Document
  include Mongoid::Slug
  include Searchable

  attr_accessor :parent_id

  scope :by_published, -> { where published: true }

  validates :title, presence: true

  after_create :make_section
  after_update :update_section

  slug :title

  field :title, localize: true, default: ''
  field :intro, localize: true, default: ''
  field :content, localize: true, default: ''
  field :published, type: Boolean, default: true
  field :css_class

  has_one :section

  settings index: {} do
    mappings dynamic: 'false' do
      indexes :title
      indexes :intro
      indexes :content
    end
  end

  def to_s
    title
  end

  private

  def make_section
    id = @parent_id.blank? ? Section.root.id.to_s : @parent_id
    Section.create parent_id: id, title: title, page: self, kind: 'page'
  end

  def update_section
    section.try :update, title_translations: title_translations
  end
end
