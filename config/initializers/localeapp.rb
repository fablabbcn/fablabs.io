if !Rails.env.production?
  require 'localeapp/rails'

  Localeapp.configure do |config|
    config.api_key = ENV['LOCALEAPP_KEY']
    # config.reloading_environments = []
    # config.polling_environments = []
  end
end
