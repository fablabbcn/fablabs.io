require_relative "boot"

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
# require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
# require "action_mailbox/engine"
# require "action_text/engine"
require "action_view/railtie"
require "action_cable/engine"
require "sprockets/railtie"
require "rails/test_unit/railtie"

require 'csv'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Fablabs
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1

    # Rails 7.1+ config.autoload_lib(ignore: %w(assets tasks templates))
    lib = root.join("lib")

    config.autoload_paths << lib
    config.eager_load_paths << lib

    Rails.autoloaders.main.ignore(
      lib.join("assets"),
      lib.join("tasks"),
      lib.join("templates")
    )
    
    # TODO: remove next line and fix tests. It's a new default since 5.0
    Rails.application.config.active_record.belongs_to_required_by_default = false

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins '*'
        resource '*', headers: :any, methods: %i[get put post options]
      end
    end

    config.i18n.fallbacks = [I18n.default_locale]
    config.i18n.enforce_available_locales = true
    config.i18n.available_locales = %i[en it de fr es ja nl pt is]
    config.i18n.default_locale = :en
    # config.i18n.backend = I18n::Backend::KeyValue.new({})

    config.generators do |g|
      g.view_specs false
      g.helper_specs false
      g.controller_specs true
      g.integration_specs true
    end

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

    config.assets.paths << Rails.root.join('vendor', 'assets')

    config.app_generators.scaffold_controller = :scaffold_controller
  end
end
