class Section
  include Mongoid::Document

  scope :by_published, -> { where published: true }

  validates :key, uniqueness: { allow_blank: true }
  validates :root, uniqueness: true, if: :root
  validates :title, presence: true, unless: :root

  before_destroy :clear_parent_field
  after_save :update_parent

  field :key
  field :title, localize: true, default: ''
  field :intro, localize: true, default: ''
  field :published, type: Boolean, default: true
  field :root, type: Boolean, default: false
  field :breadcrumbs, type: Boolean, default: true
  field :url
  field :css_class
  field :kind, default: 'section'

  belongs_to :page, dependent: :destroy
  has_and_belongs_to_many :children, class_name: 'Section', dependent: :destroy

  alias_method :base_children, :children

  def children
    base_children.sort_by do |obj|
      child_ids.index(obj.id)
    end
  end

  def self.root
    where(root: true).first
  end

  def export
    { id: id.to_s, type: self.class.name, label: title, attributes: attributes, children: children.map(&:export) }
  end

  def parent
    Section.where(id: parent_id).first
  end

  def parent_id=(parent_id)
    @old_parent_id = self.parent_id
    @parent_id = parent_id
  end

  def parent_id
    @parent_id ||= Section.where(child_ids: _id).try(:first).try :id
  end

  private

  def update_parent
    return unless @old_parent_id.to_s != @parent_id.to_s
    old_parent = Section.find @old_parent_id if @old_parent_id
    if old_parent
      old_parent.child_ids = [*old_parent.child_ids] - [_id]
      old_parent.save
    end
    new_parent = Section.where(id: @parent_id)
    new_parent = new_parent.first || Section.root
    new_parent.child_ids = [*new_parent.child_ids] + [_id]
    new_parent.save
  end

  def clear_parent_field
    parent = self.parent
    ids = parent.child_ids
    ids -= [id]
    parent.child_ids = ids
    parent.save
  end

  def self.get(key)
    Section.where(key: key.to_s).first
  end

  def to_s
    title
  end
end
