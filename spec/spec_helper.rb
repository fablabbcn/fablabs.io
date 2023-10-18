# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require 'simplecov'
SimpleCov.start 'rails'

require File.expand_path("../../config/environment", __FILE__)

require 'rspec/rails'
# require 'rspec/autorun'
require 'capybara/rspec'
#require 'headless'
# require 'sidekiq/testing'
require 'pry-byebug'
# mock support for api requests
require 'webmock/rspec'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

# Checks for pending migrations before tests are run.
# If you are not using ActiveRecord, you can remove this line.
ActiveRecord::Migration.check_pending! if defined?(ActiveRecord::Migration)


Shoulda::Matchers.configure do |config|
    config.integrate do |with|
      with.test_framework :rspec
    end
end

def log_test(message)
  Rails.logger.info(message)
  puts message
end

#Capybara.app_host = "www.fablabs.local"
#Capybara.javascript_driver = :webkit

RSpec.configure do |config|

  Zonebie.set_random_timezone

  config.include Features::SessionHelpers, type: :feature
  # Capybara.app_host = "fablabs.dev"
  # ## Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.infer_spec_type_from_file_location!

  config.include(Shoulda::Matchers::ActiveModel, type: :model)
  config.include(Shoulda::Matchers::ActiveRecord, type: :model)

  config.include RocketPants::TestHelper,    type: :request
  config.include RocketPants::RSpecMatchers, type: :request

  config.include Requests::AuthenticationHelpers
  config.include Requests::JsonHelpers, type: :request

  config.include Rails.application.routes.url_helpers, type: :request

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  # config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  # config.use_transactional_fixtures = true

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = false

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = "random"

  config.formatter = :documentation

  config.include Capybara::DSL

  # http://railscasts.com/episodes/413-fast-tests
  #config.treat_symbols_as_metadata_keys_with_true_values = true
  config.filter_run focus: false
  config.run_all_when_everything_filtered = true
  config.filter_run_excluding :slow unless ENV["SLOW_SPECS"]
  config.filter_run_excluding :ignore
  config.before(:all) { DeferredGarbageCollection.start }
  config.after(:all) { DeferredGarbageCollection.reconsider }

  config.use_transactional_fixtures = true

  config.before(:suite) do
    #Headless.new(:destroy_on_exit => false).start
  end

  config.before(:each) do
    # TODO: Should we put this stub_request somewhere else?
    WebMock.stub_request(:get, 'https://wikifactory.com/api/fablabsio/projects')
  end

  config.after(:each) do
  end

  config.include(MailerMacros)
  config.before(:each) { reset_email }
end
