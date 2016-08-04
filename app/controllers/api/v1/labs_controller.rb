class Api::V1::LabsController < Api::V0::ApiController
  include LabsOperations

  doorkeeper_for :update

  def index
    @labs = Lab.with_approved_state.joins(:projects).includes(:links, :employees, :machines).order(:slug).paginate(:page => params[:page], :per_page => 20)
    render json: @labs, each_serializer: LabJsonapiSerializer, root: "data"

  end

  def show
    @lab = with_approved_or_pending_state(params[:id])
    render json: @lab, serializer: LabJsonapiSerializer, root: "data"
  end

  def update
    @lab = Lab.friendly.find(params[:id])
    authorize_action_for @lab
    if @lab.update_attributes lab_params
      track_activity @lab
      update_workflow_state
      render json: {data: {}}
    else
      @lab.links.build
      render :edit
    end
  end
end
