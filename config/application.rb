require File.expand_path('../boot', __FILE__)

require 'rails/all'
require 'csv'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module Fablabs
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    config.i18n.default_locale = :en

    config.generators do |g|
      g.view_specs false
      g.helper_specs false
      g.controller_specs false
      g.integration_specs true
      g.fixture_replacement :factory_girl
    end

    config.url = 'http://fablabs.dev'

    config.action_mailer.default_url_options = { :host => "fablabs.io" }
    config.action_mailer.delivery_method = :smtp
    config.action_mailer.perform_deliveries = true
    config.action_mailer.raise_delivery_errors = true
    config.action_mailer.smtp_settings = {
      :authentication => ENV['EMAIL_AUTHENTICATION'],
      :address => ENV['EMAIL_ADDRESS'],
      :port => ENV['EMAIL_PORT'].to_i,
      :domain => ENV['EMAIL_DOMAIN'],
      :user_name => ENV['EMAIL_USERNAME'],
      :password => ENV['EMAIL_PASSWORD']
    }

  end
end
