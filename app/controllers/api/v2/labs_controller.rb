class Api::V2::LabsController < Api::V2::ApiController
  before_action :doorkeeper_authorize! # Requires access token for all actions
  # TODO

  # TODO
  def create
    render_json not_implemented
  end

  def show
    # Your code here
    @lab = Lab.with_approved_state.includes(:links,:machines).find(params[:id])
    render_json  ApiLabsSerializer.new(@lab, {}).serialized_json
  end

  def add_lab_machine_by_id
    render_json not_implemented
  end


  # TODO
  def get_lab_machines_by_id
    # Your code here
    render_json not_implemented
  end
 
  def index
    @labs,@paginate = paginate Lab.with_approved_state.includes(:links,:machines)
    options = {}
    options[:include] = [:links, :machines, :'machines.brand',]
    options[:meta] = {'total-pages' => @paginate[:pages] }
    options[:links] = @paginate

    render_json ApiLabsSerializer.new(@labs, options).serialized_json
  end

  def search
    @kind = params[:type] || 'fulltext'
    if @kind == 'fulltext' then
      @labs,@paginate = paginate Lab.with_approved_state.where("slug LIKE ? or name LIKE ?", "%#{params[:q]}%", "%#{params[:q].capitalize}%").includes(:links,:machines)
    else 
      @lat,@lng = params['q'].split(':')
      @labs,@paginate = paginate Lab.with_approved_state.near([@lat, @lng],100).includes(:links,:machines)
    end
    options = {}
    options[:include] = [:links, :machines, :'machines.brand',]
    options[:meta] = {'total-pages' => @paginate[:pages] }
    options[:links] = @paginate

    render_json ApiLabsSerializer.new(@labs, options).serialized_json
  end


  def map
    @map, @paginate = paginate Lab.with_approved_state.select(:latitude,:longitude,:slug,:name,:id)
    options = {}
    options[:meta] = {'total-pages' => @paginate[:pages] }
    options[:links] = @paginate
    render_json ApiMapSerializer.new(@map, options).serialized_json
  end

  # TODO
  def update
    render_json not_implemented
  end
end
