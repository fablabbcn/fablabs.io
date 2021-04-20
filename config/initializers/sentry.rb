Sentry.init do |config|
  config.dsn = ENV['RAVEN_DSN_URL']
end
