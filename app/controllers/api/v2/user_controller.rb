class Api::V2::UserController < Api::V2::ApiController

  before_action :dorkeeper_authorize!
  def current_user
    # Your code here
    expose current_user
    #render json: {"message" => "yes, it worked"}
  end

  def update_user
    render_json not_implemented
  end


end
