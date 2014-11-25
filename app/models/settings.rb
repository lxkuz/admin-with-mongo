require 'singleton'

class Settings
  include Singleton
  include Mongoid::Document
  include ImageUploading

  field :contact_email, default: ''
  field :title, localize: true, default: ''
  field :subtitle, localize: true, default: ''

  def self.instance
    @instance ||= first || new
  end
end
