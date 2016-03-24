class Api::V0::LabsController < Api::V0::ApiController

  def index
    if params[:page]
      @labs = Lab.with_approved_state.includes(:links).order(:slug).paginate(:page => params[:page], :per_page => 20)
    else
      @labs = Lab.with_approved_state.includes(:links).order(:slug)
    end
    render json: @labs, each_serializer: LabSerializer

  end

  def show
    respond_with Lab.with_approved_state.includes(:links).find(params[:id])
  end

  def map
    respond_with Lab.select(:latitude,:longitude,:name,:id)
      .with_approved_state.includes(:links),
      each_serializer: MapSerializer
  end

  def search
    @labs = Lab.where("slug LIKE ? or name LIKE ?", "%#{params[:q]}%", "%#{params[:q].capitalize}%")
    render json: @labs, each_serializer: LabSerializer
  end

end
