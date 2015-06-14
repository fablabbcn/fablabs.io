class Api::V0::UsersController < Api::V0::ApiController

  def me
    respond_with current_user
  end

  def search
    @users = User.where("first_name LIKE ?", "%#{params[:username]}%")  
    render json: @users, each_serializer: UserSerializer
  end

end
