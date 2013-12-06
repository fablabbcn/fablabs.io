class Api::V1::UsersController < Api::V1::ApiController

 # doorkeeper_for :all

  def show
    expose User.find(2)#current_user
  end

end
