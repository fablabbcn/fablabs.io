class Api::V2::AdminController < Api::V2::ApiController
  before_action :doorkeeper_authorize! # Requires access token for all actions

  def create_user
    # Your code here

    render json: {"message" => "yes, it worked"}
  end

  def get_user
    # Your code here

    render json: {"message" => "yes, it worked"}
  end

  def list_users
    # Your code here
    error! :forbidden unless current_user.has_role? :superadmin
    expose tempjson
  end

  def search_users
    # Your code here

    render json: {"message" => "yes, it worked"}
  end

  def tempjson
    {
      "message": "yes it worked"
    }
  end
end
