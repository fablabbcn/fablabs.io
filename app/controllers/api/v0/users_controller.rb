class Api::V0::UsersController < Api::V0::ApiController

  doorkeeper_for :all

  def me
    respond_with current_user
  end

end
