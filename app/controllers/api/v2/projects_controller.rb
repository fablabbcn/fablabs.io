class Api::V2::ProjectsController < Api::V2::ApiController
  before_action :doorkeeper_authorize!

  def create
    render json: not_implemented, status: :not_implemented
  end

  def show
    project = Project.friendly.find(params[:id])
    render json: ApiProjectSerializer.new(project).serialized_json
  end

  def map
    projects = Project.joins(:collaborations).includes(:lab).references(:lab)

    mapped_projects = projects.map do |p|
      {
        id: p.id,
        title: p.title,
        name: p.lab&.name,
        latitude: p.lab&.latitude,
        longitude: p.lab&.longitude,
        kind: p.lab.kind
      }
    end

    paginated, pagination = paginate(Kaminari.paginate_array(mapped_projects))

    options = {
      meta: { 'total-pages' => pagination[:pages] },
      links: pagination
    }

    render json: ApiProjectSerializer.new(paginated, options).serialized_json
  end

  def index
    projects, pagination = paginate(Project.includes(:lab, :owner))

    options = {
      meta: { 'total-pages' => pagination[:pages] },
      links: pagination
    }

    render json: ApiProjectSerializer.new(projects, options).serialized_json
  end

  def search_projects
    query = params[:q].to_s
    projects, pagination = paginate(
      Project.where("slug LIKE ? OR title LIKE ?", "%#{query}%", "%#{query.capitalize}%")
    )

    options = {
      meta: { 'total-pages' => pagination[:pages] },
      links: pagination
    }

    render json: ApiProjectSerializer.new(projects, options).serialized_json
  end

  # TODO
  def update
    render json: not_implemented, status: :not_implemented
  end
end
