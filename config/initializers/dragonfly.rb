require 'dragonfly'

# Configure
Dragonfly.app.configure do
  plugin :imagemagick

  secret "32f9326cbaa40cb9db876f37c097793fe7dde1f37dc84024f0004ad1a1ad991a"

  url_format "/media/:job/:name"

  fetch_file_whitelist [
    /public/
  ]

  datastore :s3,
    bucket_name: Figaro.env.S3_BUCKET,
    access_key_id: Figaro.env.S3_KEY,
    secret_access_key: Figaro.env.S3_SECRET,
    region: Figaro.env.S3_REGION

  # datastore :file,
  #   root_path: Rails.root.join('public/system/dragonfly', Rails.env),
  #   server_root: Rails.root.join('public')
end

# Logger
Dragonfly.logger = Rails.logger

# Mount as middleware
Rails.application.middleware.use Dragonfly::Middleware

# Add model functionality
if defined?(ActiveRecord::Base)
  ActiveRecord::Base.extend Dragonfly::Model
  ActiveRecord::Base.extend Dragonfly::Model::Validations
end
