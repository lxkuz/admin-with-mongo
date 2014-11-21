class Attachment
  include Mongoid::Document
  extend Dragonfly::Model
  extend Dragonfly::Model::Validations

  validates :file, presence: true

  dragonfly_accessor :file

  field :file_uid
  field :file_name

  belongs_to :target, polymorphic: true
end
