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
require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Fablabs
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 8.0

    # Please, add to the `ignore` list any other `lib` subdirectories that do
    # not contain `.rb` files, or that should not be reloaded or eager loaded.
    # Common ones are `templates`, `generators`, or `middleware`, for example.
    config.autoload_lib(ignore: %w(assets templates))

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    # TODO: remove next line and fix tests. It's a new default since 5.0
    Rails.application.config.active_record.belongs_to_required_by_default = false

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

    config.app_generators.scaffold_controller = :scaffold_controller
  end
end
