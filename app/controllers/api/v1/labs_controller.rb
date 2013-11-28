class Api::V1::LabsController < RocketPants::Base
  version 1

  include AbstractController::Callbacks
  include ActionController::Head
  include Doorkeeper::Helpers::Filter

  doorkeeper_for :all

  def index
    expose Lab.with_approved_state
  end

end
