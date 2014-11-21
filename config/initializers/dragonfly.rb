require 'dragonfly'

# Configure
Dragonfly.app.configure do
  plugin :imagemagick

  secret 'e03db74bb9d803cf7670e957542a8fd9abdbb85b2676227ac3479f5da1657c73'

  url_format '/media/:job/:name'

  datastore :file,
    root_path: Rails.root.join('public/uploads', Rails.env),
    server_root: Rails.root.join('public')

  # processors
  processor :large do |content|
    content.process!(:convert, "-resize '1052x350^' -gravity center")
    content.process!(:encode, 'png')
  end

  processor :xmedium do |content|
    content.process!(:convert, "-resize '320x200^' -gravity center")
    content.process!(:encode, 'png')
  end

  processor :medium do |content|
    content.process!(:convert, "-resize '200x150!' -gravity center")
    content.process!(:encode, 'png')
  end

  processor :small do |content|
    content.process!(:convert, "-resize 'x130^' -gravity center -crop '130x130+0+0'")
    content.process!(:encode, 'png')
  end
end

# Logger
Dragonfly.logger = Rails.logger

# Mount as middleware
Rails.application.middleware.use Dragonfly::Middleware
