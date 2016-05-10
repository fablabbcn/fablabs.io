class Api::V0::UsersController < Api::V0::ApiController

  def me
    render json: current_user
  end

  def search
    @users = User.where("first_name LIKE ? or username LIKE ? or last_name LIKE ?", "%#{ params[:q].capitalize }%", "%#{ params[:q] }%", "%#{ params[:q].capitalize }%")
    render json: @users, each_serializer: UserSerializer
  end

end
