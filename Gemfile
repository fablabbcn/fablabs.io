ruby File.read(".ruby-version").strip

source 'https://rubygems.org'

gem 'rails','~> 8.1.0'

#The `content_tag_for` method has been removed from Rails. To continue using it, add the `record_tag_helper` gem to your Gemfile:
gem 'record_tag_helper'

gem 'active_model_serializers'
gem 'activeadmin', '4.0.0.beta23'
gem 'acts-as-taggable-on'
gem 'ancestry'#, github: 'stefankroes/ancestry'
gem 'authority'#, github: 'nathanl/authority'
gem 'bitmask_attributes'
# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false
gem 'bootstrap4-kaminari-views'
gem 'chartkick'
gem 'cocoon'
gem 'coderay'
gem 'countries', require: 'countries/global'
gem 'country_select'
gem 'discourse_api'
gem 'doorkeeper', '~>5.9.0'
gem 'dotenv-rails'
gem 'dragonfly', '~> 1.4.0'
gem 'dragonfly-s3_data_store', '~> 1.3.0'
gem 'jsonapi-serializer', '~> 2.2' # To support JSONAPI.org format
gem "font-awesome-sass", "~> 6.5" # https://docs.fontawesome.com/v6/web/use-with/ruby-on-rails
gem 'friendly_id'
gem 'groupdate' #used by chartkick
gem 'geocoder'
gem 'gibbon'
gem 'haml-rails'
gem 'http_accept_language'
gem 'httparty'
gem 'inherited_resources'
gem 'invisible_captcha'
# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem 'jbuilder'
gem 'kaminari'
gem 'letter_opener'
gem 'nest'
gem 'paper_trail'
gem 'pg'
gem 'pg_search'
gem 'premailer-rails'
# Use the Puma web server [https://github.com/puma/puma]
gem "puma", ">= 5.0"
gem 'rack-attack'
gem 'rack-cache'
gem 'rack-cors', require: 'rack/cors'
gem 'ransack'
gem 'redcarpet'
gem 'redis'
gem 'rolify'
gem 'rspec'
gem 'sentry-ruby'
gem 'sentry-rails'
gem 'sidekiq'
gem 'simplecov', :require => false, :group => :test
gem 'simple_form'
gem 'sitemap_generator'
gem 'slim'
gem 'sort_alphabetical'
gem 'stamp'
# Asset pipeline: Propshaft (digests & serves), Dart Sass (stylesheets), esbuild (JavaScript)
# The modern asset pipeline for Rails [https://github.com/rails/propshaft]
gem 'propshaft'
gem 'jsbundling-rails'
gem 'cssbundling-rails' # used by ActiveAdmin (Tailwind CSS build)
# Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
gem 'importmap-rails'   # used by ActiveAdmin (admin JS via importmap)
gem 'csv'
gem 'timezone'#, '~> 1.0'
gem 'workflow-activerecord', '~> 6.0' # https://github.com/geekq/workflow-activerecord

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', '~> 2.3', require: false
end

group :development do
  gem 'listen' # explicitd added (when not installing test gems)
  gem 'bullet' #, github: 'flyerhzm/bullet'
  gem "i18n-tasks"
  gem 'net-ssh'
  gem 'web-console'
  gem 'rack-mini-profiler'
end

group :test, :development do
  gem 'byebug'
  gem 'factory_bot_rails'
  gem 'ffaker'
  gem 'pry-byebug'
  gem 'pry-rails'
  gem 'rspec-rails'
end

group :test do
  gem 'capybara', '~> 3.40.0'
  gem 'guard-rspec'
  gem 'launchy'
  gem 'minitest'
  gem 'pry'
  gem 'pry-rescue'
  gem 'pry-stack_explorer'
  gem 'rails-controller-testing'
  gem 'selenium-webdriver', '~> 4.0'
  gem 'shoulda-matchers'
  gem 'test-unit'
  gem 'webmock'
  gem 'zonebie'
end

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
gem 'bcrypt'

# gem 'foreman'
# gem 'unicorn'

# Use unicorn as the app server
# gem 'unicorn'
