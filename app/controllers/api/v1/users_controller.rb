class Api::V1::UsersController < Api::V1::ApiController

 doorkeeper_for :all

  def show
    expose current_user
  end

  def search
    @users = User.where(username: params['username']).map{ |u| [ u.username, u.id ] }
    render json: @users
  end

end
