require "opbeat"

Opbeat.configure do |config|
 config.organization_id = ENV["OPBEAT_ORG_ID"]
 config.app_id = ENV["OPBEAT_APP_ID"]
 config.secret_token = ENV["OPBEAT_SECRET"]
end
