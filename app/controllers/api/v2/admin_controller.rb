class Api::V2::AdminController < Api::V2::ApiController
  before_action :dorkeeper_authorize!
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

    render json: {"message" => "yes, it worked"}
  end

  def search_users
    # Your code here

    render json: {"message" => "yes, it worked"}
  end
end
