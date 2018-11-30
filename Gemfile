ruby '2.5.3'

source 'https://rubygems.org'

gem 'puma'
gem 'rspec'
gem 'discourse_api'
gem 'protected_attributes'
gem 'hpricot'
gem 'premailer-rails'
gem 'rack-cors', :require => 'rack/cors'
gem 'http_accept_language'
gem 'chronic'
gem 'whenever', :require => false
gem 'slim'
gem 'dalli'
gem 'sitemap_generator'
gem "rack-cache"
gem 'simplecov', :require => false, :group => :test
gem 'paper_trail'
gem 'sort_alphabetical'
gem 'rocket_pants'# '~> 1.0'
gem 'fast_jsonapi' # To support new v2 JSONAPI
gem 'twitter'
gem "sentry-raven"
gem 'sinatra', '>= 1.3.0', :require => nil
gem 'nest'
gem 'rails' 
gem 'sidekiq'#, '~> 4' # Should sidekiq stay on the same major version as Rails?
gem 'inherited_resources'
gem 'timezone'#, '~> 1.0'
gem 'bitmask_attributes'
gem 'ransack'#, github: "ernie/ransack"
gem 'authority'#, github: 'nathanl/authority'
gem 'rolify'#, github: 'EppO/rolify'
gem 'font-awesome-rails'#, github: 'bokmann/font-awesome-rails'
gem 'acts-as-taggable-on'
gem 'kaminari'
gem 'ancestry'#, github: 'stefankroes/ancestry'
gem 'geocoder'#, github: 'alexreisner/geocoder'
gem 'workflow'#, github: 'geekq/workflow'
gem 'bourbon'
gem "cocoon"#, github: 'nathanvda/cocoon', :tag => 'v1.2.7'
gem "pg_search"
gem "pg",'0.17.1'
gem 'simple_form'#, '3.0.1'
gem 'countries', require: 'countries/global'
gem 'country_select'
gem 'momentjs-rails'
gem 'active_model_serializers'
gem 'stamp'
gem 'sass-rails'#, '~> 4.0.5'
gem 'sprockets-rails'
gem 'sprockets'#,'~> 2.11.0' # 2.12 errors on SASS files
gem 'haml-rails'
gem 'uglifier'#, '>= 1.3.0'
gem 'font-awesome-sass'#, '~> 4.3.0'
gem 'trumbowyg_rails'#, git: 'https://github.com/TikiTDO/trumbowyg_rails.git'

gem 'database_cleaner'#, github: 'bmabey/database_cleaner'
gem 'letter_opener'
gem 'coffee-rails'#, '~> 4.0.0'
gem 'jquery-rails'


gem 'dragonfly'#, '~> 1.1.1'
gem 'dragonfly-s3_data_store'

gem "paperclip"#, "~> 4.2"
# For paperclip/refile we need:
gem 'aws-s3'
gem 'aws-sdk-v1' # Can be used together with v2 because of different namespaces.

gem 'jbuilder'#, '~> 1.2'

gem 'figaro'
gem 'friendly_id'#, '~> 5.1.0'
gem 'ffaker'
gem 'doorkeeper'

gem 'redcarpet'
gem 'coderay'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

group :development do
  gem 'bullet' #, github: 'flyerhzm/bullet'
  gem 'quiet_assets'
  gem 'net-ssh'
end

group :test, :development do
  gem 'pry-rails'
  gem 'pry-byebug'
  gem 'byebug'
  gem "rspec-rails"
  gem "factory_bot_rails"
end

group :test do
  gem 'minitest'
  gem 'zonebie'
  gem "launchy"
  gem "capybara"
  gem "selenium-webdriver"
  gem "capybara-webkit"
  gem "guard-rspec"
  gem "shoulda-matchers"
  gem "codeclimate-test-reporter", require: nil
  gem "pry"
  gem "pry-rescue"
  gem "pry-stack_explorer"
  gem "test-unit"
end


# Use ActiveModel has_secure_password
gem 'bcrypt-ruby'

# gem 'foreman'
gem 'unicorn'

# Use unicorn as the app server
# gem 'unicorn'
