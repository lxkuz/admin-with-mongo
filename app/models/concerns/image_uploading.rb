module ImageUploading
  extend ActiveSupport::Concern

  included do
    extend Dragonfly::Model
    extend Dragonfly::Model::Validations

    dragonfly_accessor :image
    field :image_uid
    field :image_name
  end
end
