class Api::V1::LabsController < RocketPants::Base
  version 1

  def index
    expose Lab.with_approved_state
  end

end
