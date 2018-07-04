class Api::V2::UserController < Api::V2::ApiController
  before_action :doorkeeper_authorize! # Requires access token for all actions


  def me
    # Your code here
    
    render_json ApiUserSerializer.new(current_user,{}).serialized_json
    #render json: {"message" => "yes, it worked"}
  end

  def update_user
    render_json not_implemented
  end


end
