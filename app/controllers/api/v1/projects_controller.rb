class Api::V1::ProjectsController < Api::V1::ApiController
  def index
    @projects = Project.all.joins(:collaborations).includes(:lab).references(:lab)
    render json: @projects, each_serializer: ProjectJsonapiSerializer, root: "data"

  end

  def show
    @project = Project.find(params[:id])
    render json: @project, serializer: ProjectJsonapiSerializer, root: "data"
  end
end
