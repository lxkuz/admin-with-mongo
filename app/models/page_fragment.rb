class PageFragment
  include Mongoid::Document
  include Mongoid::Slug

  KEY_REGEXP = /\A[a-z_.]+\z/

  validates :key, presence: true, uniqueness: true, format: { with: KEY_REGEXP }
  validates :name, presence: true

  scope :visible, -> { where hidden: false }

  slug :key

  field :key
  field :name
  field :content, localize: true, default: ''
  field :hidden, type: Boolean, default: false

  module Configuring
    def self.fragment(*args)
      name = args.flatten.last
      keys = args.flatten[0..-2]
      PageFragment::Configuring.init keys, name
    end

    def self.init(keys, name)
      key = PageFragment.parse_key keys.flatten
      item = PageFragment.where(key: key).first || PageFragment.new(key: key)
      item.name = name
      item.hidden = false
      item.save
    end
  end

  def to_s
    I18n.t("page_fragments.#{key}.name")
  end

  def short_name
    I18n.t("page_fragments.#{key}.name")
  end

  def keys
    (key || '').split('.')
  end

  def parents
    names = []
    keys.each { |k| names << [names.last, k].join('.') }
    names
  end

  def nesting_level
    keys.size
  end

  def self.config(&block)
    PageFragment.visible.each { |pf| pf.hidden = true, pf.save(validate: false) }
    PageFragment::Configuring.instance_eval(&block)
  end

  def self.get(*keys)
    key = PageFragment.parse_key keys.flatten
    PageFragment.visible.where(key: key).first
  end

  def self.parse_key(*keys)
    keys.flatten.map(&:to_s).join('.')
  end
end
