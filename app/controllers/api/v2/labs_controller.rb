class Api::V2::LabsController < Api::V2::ApiController
  before_action :doorkeeper_authorize! # Requires access token for all actions
  # TODO
  def add_lab_machine_by_id
    render_json not_implemented

  end

  # TODO
  def create
    render_json not_implemented

  end


  def show
    # Your code here
    @lab = Lab.with_approved_state.includes(:links).find(params[:id])
    render_json  ApiLabsSerializer.new(@lab, {}).serialized_json
  end

  # TODO
  def get_lab_machines_by_id
    # Your code here

    render_json not_implemented
  end

  def index
    @labs,@paginate = paginate Lab.with_approved_state.includes(:links)
    options = {}
    options[:meta] = {'total-pages' => @paginate['pages'] }
    options[:links] = @paginate

    render_json ApiLabsSerializer.new(@labs, options).serialized_json
  end

  def search_labs
    # Your code here
    @labs,@paginate = paginate Lab.with_approved_state.where("slug LIKE ? or name LIKE ?", "%#{params[:q]}%", "%#{params[:q].capitalize}%")
    options = {}
    options[:meta] = {'total-pages' => @paginate['pages'] }
    options[:links] = @paginate

    render_json ApiLabsSerializer.new(@labs, options).serialized_json
  end

  # TODO
  def update
    render_json not_implemented

  end
end
