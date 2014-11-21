class Settings
  include Mongoid::Document
  include ImageUploading

  field :contact_email, default: ''
  field :title, localize: true, default: ''
  field :subtitle, localize: true, default: ''

  def self.instance
    @instance ||= Settings.first || Settings.new
  end

  private def new
    super
  end
end
