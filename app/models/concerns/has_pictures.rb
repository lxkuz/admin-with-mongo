module HasPictures
  extend ActiveSupport::Concern

  included do
    has_many :pictures, as: :target

    def build_pictures(hash)
      hash.each do |_, val|
        Picture.create target: self, file: val
      end if hash
    end
  end
end
