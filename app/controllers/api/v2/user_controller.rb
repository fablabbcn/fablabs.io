class Api::V2::UserController < Api::V2::ApiController
  before_action :doorkeeper_authorize! # Requires access token for all actions


  def me
    # Your code here
    
    render json: ApiUserSerializer.new(current_user, {}).serialized_json
  end

  def update_user
    render json: not_implemented, status: :not_implemented
  end


end
