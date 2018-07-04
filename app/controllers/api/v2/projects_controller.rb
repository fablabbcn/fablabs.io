class Api::V2::ProjectsController <  Api::V2::ApiController
  before_action :doorkeeper_authorize!

  #TODO
  def create
    render_json not_implemented
  end

  def show
    # Your code here
    render_json ApiProjectSerializer.new( Project.friendly.find(params[:id])).serialized_json
  end

  def map
     @projects,@pagination = paginate Project.joins(:collaborations).includes(:lab).references(:lab).collect { |p| {id: p.id, title: p.title, name: p.lab.name, latitude: p.lab.latitude, longitude: p.lab.longitude, kind: p.lab.kind_name}}
     options = {}
     options[:meta] = {'total-pages' => @pagination[:pages] }
     options[:links] = @pagination
     render_json ApiProjectSerializer.new(@projects, options).serialized_json
  end

  def index

    @projects,@pagination = paginate Project.all.includes(:lab,:owner)
    options = {}
    options[:meta] = {'total-pages' => @pagination[:pages] }
    options[:links] = @pagination
    render_json ApiProjectSerializer.new(@projects, options).serialized_json
  end

  def search_projects

    @projects,@pagination = paginate Project.where("slug LIKE ? or title LIKE ?", "%#{params[:q]}%", "%#{params[:q].capitalize}%")
    options = {}
    options[:meta] = {'total-pages' => @pagination[:pages] }
    options[:links] = @pagination
    render_json ApiProjectSerializer.new(@projects, options).serialized_json
  end

  # TODO
  def update
    render_json not_implemented
  end
end
