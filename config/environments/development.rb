# require 'sidekiq/testing/inline'

Fablabs::Application.configure do

  # config.after_initialize do
  #   Bullet.enable = true
  #   Bullet.alert = true
  #   Bullet.bullet_logger = true
  #   Bullet.console = true
  #   # Bullet.growl = true
  #   # Bullet.xmpp = { :account  => 'bullets_account@jabber.org',
  #   #                 :password => 'bullets_password_for_jabber',
  #   #                 :receiver => 'your_account@jabber.org',
  #   #                 :show_online_status => true }
  #   Bullet.rails_logger = true
  #   Bullet.airbrake = true
  #   Bullet.add_footer = true
  # end

  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  config.banned_words = (YAML.load_file("#{Rails.root}/config/words.yml") || {}).map(&:values).flatten

# config.action_controller.asset_host = "https://assets.fablabs.io"
  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports and disable caching.
  config.consider_all_requests_local       = true


  config.action_controller.perform_caching = false
  config.cache_store = :dalli_store, 'memcached://localhost:11211/meta', { expires_in: 90.minutes }
  config.action_dispatch.rack_cache = {
    metastore:   'memcached://localhost:11211/meta',
    entitystore: 'memcached://localhost:11211/body'
  }

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations
  config.active_record.migration_error = :page_load

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true

  # config.action_mailer.raise_delivery_errors = false
  # config.action_mailer.perform_deliveries = true
  # config.action_mailer.raise_delivery_errors = true
  # config.action_mailer.delivery_method = :smtp

  config.action_mailer.delivery_method = :letter_opener
  config.action_mailer.default_url_options = { :host => "fablabs.dev" }
end
