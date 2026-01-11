ruby File.read(".ruby-version").strip

source 'https://rubygems.org'

gem 'rails','~> 6.1.0'

#The `content_tag_for` method has been removed from Rails. To continue using it, add the `record_tag_helper` gem to your Gemfile:
gem 'record_tag_helper'

gem 'active_model_serializers'
gem 'activeadmin', '~> 3.4'
gem 'acts-as-taggable-on'
gem 'ancestry'#, github: 'stefankroes/ancestry'
gem 'authority'#, github: 'nathanl/authority'
gem 'bitmask_attributes'
gem 'bootsnap'
gem 'bootstrap4-kaminari-views'
gem 'chartkick'
gem 'cocoon'
gem 'coderay'
gem 'countries', '~> 5', require: 'countries/global'
gem 'country_select', '~> 8.0'
gem 'dalli', '~> 3.2.3'
gem 'discourse_api'
gem 'doorkeeper', '~>5.8.0'
gem 'dotenv-rails'
gem 'dragonfly', '~> 1.4.0'
gem 'dragonfly-s3_data_store', '~> 1.3.0'
gem 'jsonapi-serializer', '~> 2.2' # To support JSONAPI.org format
gem 'flatpickr'
gem "font-awesome-sass", "~> 6.5" # https://docs.fontawesome.com/v6/web/use-with/ruby-on-rails
gem 'friendly_id'
gem 'groupdate' #used by chartkick
gem 'geocoder'
gem 'gibbon'
gem 'haml-rails'
gem 'hpricot'
gem 'http_accept_language'
gem 'httparty'
gem 'inherited_resources'
gem 'invisible_captcha'
gem 'jbuilder'
gem 'jquery-rails'
gem 'kaminari'
gem 'letter_opener'
gem 'momentjs-rails' # Remove? It is already included with Chart.js bundle
gem 'nest'
gem 'paper_trail'
gem 'pg'
gem 'pg_search'
gem 'premailer-rails'
gem 'puma'
gem 'rack-attack'
gem 'rack-cache'
gem 'rack-cors', require: 'rack/cors'
gem 'ransack'
gem 'redcarpet'
gem 'redis'
gem 'rolify'
gem 'rspec'
gem 'sassc-rails'
gem 'coffee-rails'
gem 'sentry-ruby'
gem 'sentry-rails'
gem 'sidekiq', '< 8'
gem 'simplecov', :require => false, :group => :test
gem 'simple_form'
gem 'sitemap_generator'
gem 'slim'
gem 'sort_alphabetical'
gem 'sprockets'
gem 'sprockets-rails'
gem 'stamp'
gem 'timezone'#, '~> 1.0'
gem 'uglifier'#, '>= 1.3.0'
gem 'workflow-activerecord', '~> 6.0' # https://github.com/geekq/workflow-activerecord

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', '2.3.1', require: false
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

# Use ActiveModel has_secure_password
gem 'bcrypt'

# gem 'foreman'
# gem 'unicorn'

# Use unicorn as the app server
# gem 'unicorn'
