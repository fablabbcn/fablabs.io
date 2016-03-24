require "opbeat"

# set up an Opbeat configuration
config = Opbeat::Configuration.new do |conf|
  conf.organization_id = ENV["OPBEAT_ORG_ID"]
  conf.app_id = ENV["OPBEAT_APP_ID"]
  conf.secret_token = ENV["OPBEAT_SECRET"]
end
