class Api::LabsController < Api::ApiController

  def index
    @labs = Lab.with_approved_state.includes(:links)
    render json: @labs, each_serializer: LabSerializer
  end

end
