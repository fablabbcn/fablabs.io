# frozen_string_literal: true

require File.expand_path('boot', __dir__)

require 'rails/all'
require 'csv'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
# Bundler.require(:default, Rails.env)

Bundler.require(*Rails.groups)

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

    config.middleware.insert_before 0, 'Rack::Cors' do
      allow do
        origins '*'
        resource '*', headers: :any, methods: %i[get put post options]
      end
    end

    config.i18n.fallbacks = true
    config.i18n.enforce_available_locales = true
    config.i18n.available_locales = %i[en it de fr es ja nl pt]
    config.i18n.default_locale = :en
    # config.i18n.backend = I18n::Backend::KeyValue.new({})

    # config.i18n.fallbacks = false

    config.generators do |g|
      g.view_specs false
      g.helper_specs false
      g.controller_specs true
      g.integration_specs true
      g.fixture_replacement :factory_girl
    end

    #
    # Paperclip configuration options
    #
    config.paperclip_defaults = {
      storage: :s3,
      s3_credentials: {
        bucket: ENV['AWS_BUCKET'],
        access_key_id: ENV['AWS_ACCESS_KEY_ID'],
        secret_access_key: ENV['AWS_SECRET'],
        s3_host_name: 's3-eu-west-1.amazonaws.com'
      }
    }

    config.google_maps_api_key = ENV['GOOGLE_API_KEY']

    config.url = 'http://fablabs.local'

    config.action_mailer.default_url_options = { host: 'www.fablabs.io', protocol: 'https' }
    config.action_mailer.delivery_method = :smtp
    config.action_mailer.perform_deliveries = true
    config.action_mailer.raise_delivery_errors = true
    config.action_mailer.smtp_settings = {
      authentication: ENV['EMAIL_AUTHENTICATION'],
      address: ENV['EMAIL_ADDRESS'],
      port: ENV['EMAIL_PORT'].to_i,
      domain: ENV['EMAIL_DOMAIN'],
      user_name: ENV['EMAIL_USERNAME'],
      password: ENV['EMAIL_PASSWORD']
    }

    if ENV['RAVEN_DSN_URL'].present?
      Raven.configure do |config|
        config.dsn = ENV['RAVEN_DSN_URL']
      end
    end

    config.autoload_paths += %W[#{config.root}/lib]
    config.assets.paths << Rails.root.join('vendor', 'assets')
    config.active_record.raise_in_transactional_callbacks = true
  end
end
