source 'https://rubygems.org'

## Rails

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.1.6'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.3'
# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'
# Use jquery as the JavaScript library
gem 'jquery-rails'
# Embed the V8 Javascript Interpreter into Ruby
gem 'therubyracer', platforms: :ruby

## Basic

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin]

## Assets

# Foundation for Rails http://foundation.zurb.com
gem 'bootstrap-sass', '~> 3.3.1'
# Font-Awesome Sass gem for use in Ruby/Rails projects
gem 'font-awesome-sass'
# Parse CSS and add vendor prefixes to rules by Can I Use https://twitter.com/autoprefixer
gem 'autoprefixer-rails'

## Database

# Ruby ODM framework for MongoDB
gem 'mongoid'
# Generates a URL slug/permalink based on fields in a Mongoid-based model
gem 'mongoid_slug'

## Models

# Elasticsearch integrations for ActiveModel/Record and Ruby on Rails
gem 'elasticsearch-model'
gem 'elasticsearch-rails'
gem 'elasticsearch-persistence'
# A Scope & Engine based, clean, powerful, customizable and sophisticated paginator for Rails
gem 'kaminari'
# A Ruby gem for on-the-fly processing - suitable for image uploading in Rails
gem 'dragonfly'

## Controllers & views

# Maps controller filters to your resource scopes
gem 'has_scope'
# A set of Rails responders to dry up your application
gem 'responders'
# Forms made easy for Rails! It's tied to a simple DSL, with no opinion on markup
gem 'simple_form', '~> 3.1.0.rc2'
# Kaminari Views for Twitter Bootstrap
gem 'kaminari-bootstrap'
# Easy method to handle logic behind active links
gem 'active_link_to'

## Templates

# Slim templates generator for Rails 3 and 4
gem 'slim-rails'
# HTML Abstraction Markup Language - A Markup Haiku http://haml.info
gem 'haml'
# Client and Server side Jade template compiler for Rails
gem 'jader'

## Authorization

# Flexible authentication solution for Rails with Warden
gem 'devise'
# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'

## Docs

# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

## Environments

group :production do
  # Use unicorn as the app server
  gem 'unicorn', platforms: :ruby
  # Real HTTP Caching for Ruby Web Apps
  gem 'rack-cache', require: 'rack/cache'
end

group :development do
  # Use Capistrano for deployment
  gem 'capistrano-rails'
  # Bundler support for Capistrano 3.x
  gem 'capistrano-bundler'
  # RVM support for Capistrano v3
  gem 'capistrano-rvm'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end
