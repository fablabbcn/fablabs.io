class Api::V0::LabsController < Api::V0::ApiController

  def index
    respond_with Lab.with_approved_state.includes(:links)
  end

  def show
    respond_with Lab.with_approved_state.includes(:links).find(params[:id])
  end

  def map
    respond_with Lab.select(:latitude,:longitude,:name,:id)
      .with_approved_state.includes(:links),
      each_serializer: MapSerializer
  end

end
