class Api::V2::ApiController < RocketPants::Base
  version 2
  include AbstractController::Callbacks
  include ActionController::Head


protected

  def current_resource_owner
    User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
  end

  def current_user
    if doorkeeper_token
      @current_user ||= User.find(doorkeeper_token.resource_owner_id)
    end
  end

end
