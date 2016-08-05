class Api::V1::ProjectsController < Api::V1::ApiController
  def index
    @projects = Project.all.joins(:collaborations, :contributions).includes(:lab).references(:lab)
    render json: @projects, each_serializer: ProjectJsonapiSerializer, root: "data"

  end

  def show
    @project = Project.joins(:collaborations, :contributions).includes(:lab).references(:lab).find(params[:id])
    render json: @project, serializer: ProjectJsonapiSerializer, root: "data"
  end
end
