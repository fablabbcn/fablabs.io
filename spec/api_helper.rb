RSpec.configure do |config|
  # other config options

  config.before(:each) do
    !host = "api.fablabs.io"
  end
end
