class Api::V1::UsersController < Api::V1::ApiController

 doorkeeper_for :all

  def show
    expose current_user
  end

end
