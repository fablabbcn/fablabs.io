class Api::V1::LabsController < Api::V0::ApiController
  def index
    @labs = Lab.with_approved_state.includes(:links).order(:slug).paginate(:page => params[:page], :per_page => 20)
    render json: @labs, each_serializer: LabSerializer

  end

end
