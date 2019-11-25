ruby '2.5.5'
source 'https://rubygems.org'

gem 'rails','~> 5.1.7'
gem "pg"#,'0.19'
gem 'workflow', '~> 2.0'#, github: 'geekq/workflow'
gem 'workflow-activerecord', '>=4.1', '< 6.0'
# Gems blocking rails 5 update:
#gem 'sinatra', '>= 1.3.0', :require => nil

# Using community gems because official support does not cover Rails 5
# Consider refactor not to use them or find alternatives.
gem 'rocket_pants', git: 'https://github.com/parse/rocket_pants'
gem 'protected_attributes_continued'

#The `content_tag_for` method has been removed from Rails. To continue using it, add the `record_tag_helper` gem to your Gemfile:
gem 'record_tag_helper'

# Other Gem issues:
gem 'font-awesome-sass', '~> 4.3.0' # https://fontawesome.com/how-to-use/on-the-web/setup/upgrading-from-version-4
gem 'country_select', '1.2.0' # https://github.com/stefanpenner/country_select/blob/master/UPGRADING.md
gem 'bourbon', '~> 4' # Breaks transition in header.css.scss and map.css.scss https://github.com/thoughtbot/bourbon/blob/master/CHANGELOG.md

gem "cocoon"#, github: 'nathanvda/cocoon', :tag => 'v1.2.7'
gem "pg_search"
gem "rack-cache"
gem "sentry-raven"
gem 'active_model_serializers'
gem 'acts-as-taggable-on'
gem 'ancestry'#, github: 'stefankroes/ancestry'
gem 'authority'#, github: 'nathanl/authority'
gem 'bitmask_attributes'
gem 'chronic'
gem 'coderay'
gem 'coffee-rails'#, '~> 4.0.0'
gem 'countries', require: 'countries/global'
gem 'dalli'
gem 'discourse_api'
gem 'doorkeeper'
gem 'dragonfly'#, '~> 1.1.1'
gem 'dragonfly-s3_data_store'
gem 'fast_jsonapi' # To support new v2 JSONAPI
gem 'ffaker'
gem 'figaro'
gem 'font-awesome-rails'#, github: 'bokmann/font-awesome-rails'
gem 'friendly_id'#, '~> 5.1.0'
gem 'geocoder'#, github: 'alexreisner/geocoder'
gem 'haml-rails'
gem 'hpricot'
gem 'http_accept_language'
gem 'inherited_resources'
gem 'jbuilder'#, '~> 1.2'
gem 'jquery-rails'
gem 'kaminari'
gem 'letter_opener'
gem 'momentjs-rails'
gem 'nest'
gem 'paper_trail'
gem 'premailer-rails'
gem 'puma'
gem 'rack-cors', :require => 'rack/cors'
gem 'ransack','<2'
gem 'redcarpet'
gem 'rolify'#, github: 'EppO/rolify'
gem 'rspec'
gem 'sass-rails'#, '~> 4.0.5'
gem 'sidekiq'#, '~> 4' # Should sidekiq stay on the same major version as Rails?
gem 'simple_form'#, '3.0.1'
gem 'simplecov', :require => false, :group => :test
gem 'sitemap_generator'
gem 'slim'
gem 'sort_alphabetical'
gem 'sprockets'#,'~> 2.11.0' # 2.12 errors on SASS files
gem 'sprockets-rails'
gem 'stamp'
gem 'timezone'#, '~> 1.0'
gem 'trumbowyg_rails'#, git: 'https://github.com/TikiTDO/trumbowyg_rails.git'
gem 'twitter'
gem 'uglifier'#, '>= 1.3.0'

gem "paperclip"#, "~> 4.2"
# For paperclip/refile we need:
gem 'aws-s3'
gem 'aws-sdk-v1' # Can be used together with v2 because of different namespaces.

gem 'gibbon'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

group :development do
  gem 'bullet' #, github: 'flyerhzm/bullet'
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
  gem 'webmock'
  gem 'minitest'
  gem 'zonebie'
  gem "launchy"
  gem "capybara"
  gem "selenium-webdriver"
  gem "capybara-webkit"
  gem 'rails-controller-testing'
  gem "guard-rspec"
  gem "shoulda-matchers"
  gem "pry"
  gem "pry-rescue"
  gem "pry-stack_explorer"
  gem "test-unit"
end


# Use ActiveModel has_secure_password
gem 'bcrypt'

# gem 'foreman'
#gem 'unicorn'

# Use unicorn as the app server
# gem 'unicorn'
