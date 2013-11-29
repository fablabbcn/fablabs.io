class Api::V1::ApiController < RocketPants::Base
  version 1
  include AbstractController::Callbacks
  include ActionController::Head
  include Doorkeeper::Helpers::Filter
protected
  def current_user
    if doorkeeper_token
      @current_user ||= User.find(doorkeeper_token.resource_owner_id)
    end
  end
end
