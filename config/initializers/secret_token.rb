if Rails.env.production? && ENV['SECRET_TOKEN'].blank?
  raise 'SECRET_TOKEN environment variable must be set!'
end

Fablabs::Application.config.secret_key_base = ENV['SECRET_TOKEN'] || '6420047123bb6130141ad3b794db3f3a6762721cd32da4cded5e328a458e37ea71c5f12ad8e943da582144f995ed7b653cda9fec5c2fea48ed6c68cacf090a2c'
