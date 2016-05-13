class Api::V1::UsersController < Api::V1::ApiController

  doorkeeper_for :all

  def me
    render json: current_user, serializer: UserJsonapiSerializer, root: "data" 
  end

end
