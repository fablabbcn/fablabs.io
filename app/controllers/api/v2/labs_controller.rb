class Api::V2::LabsController < Api::V2::ApiController
  before_action :doorkeeper_authorize!

  def index
    @labs, @paginate = paginate Lab.with_approved_state.includes(:links, :machines)
    options = {
      include: [:links, :machines, :'machines.brand'],
      meta: { 'total-pages' => @paginate[:pages] },
      links: @paginate
    }

    render json: ApiLabsSerializer.new(@labs, options).serialized_json
  end

  def show
    @lab = Lab.with_approved_state.includes(:links, :machines).find(params[:id])
    render json: ApiLabsSerializer.new(@lab, {}).serialized_json
  end

  def map
    @map, @paginate = paginate Lab.with_approved_state.select(:latitude, :longitude, :slug, :name, :id, :kind)
    options = {
      meta: { 'total-pages' => @paginate[:pages] },
      links: @paginate
    }

    render json: ApiMapSerializer.new(@map, options).serialized_json
  end

  def search
    if params[:type] == 'fulltext' || params[:type].blank?
      @labs, @paginate = paginate Lab.with_approved_state
        .where("slug LIKE ? OR name LIKE ?", "%#{params[:q]}%", "%#{params[:q].capitalize}%")
        .includes(:links, :machines)
    else
      @lat, @lng = params[:q].split(':')
      @labs, @paginate = paginate Lab.with_approved_state
        .near([@lat, @lng], 100)
        .includes(:links, :machines)
    end

    options = {
      include: [:links, :machines, :'machines.brand'],
      meta: { 'total-pages' => @paginate[:pages] },
      links: @paginate
    }

    render json: ApiLabsSerializer.new(@labs, options).serialized_json
  end

  def create
    render json: not_implemented, status: :not_implemented
  end

  def update
    render json: not_implemented, status: :not_implemented
  end

  def add_lab_machine_by_id
    render json: not_implemented, status: :not_implemented
  end

  def get_lab_machines_by_id
    render json: not_implemented, status: :not_implemented
  end
end
