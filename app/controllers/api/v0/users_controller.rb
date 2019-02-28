# frozen_string_literal: true

class Api::V0::UsersController < Api::V0::ApiController
  def me
    respond_with current_user
  end

  def search
    @users = []
    if params[:q] && (params[:q].length > 3)
      @users = User.where('first_name LIKE ? or username LIKE ? or last_name LIKE ?', "%#{params[:q]&.capitalize}%", "%#{params[:q]}%", "%#{params[:q]&.capitalize}%")
    end
    render json: @users, each_serializer: UserSerializer
  end
end
