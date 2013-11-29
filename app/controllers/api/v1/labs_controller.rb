class Api::V1::LabsController < Api::V1::ApiController

  def index
    expose Lab.with_approved_state
  end

end
