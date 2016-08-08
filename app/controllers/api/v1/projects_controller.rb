class Api::V1::ProjectsController < Api::V1::ApiController
  def index
    @projects = Project.all.includes(:lab, :collaborations, :contributions)
    render json: @projects, each_serializer: ProjectJsonapiSerializer, root: "data"

  end

  def show
    @project = Project.find(params[:id])
    render json: @project, serializer: ProjectJsonapiSerializer, root: "data"
  end
end
