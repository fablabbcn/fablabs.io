class Api::V2::LabsController < Api::V2::ApiController
  before_action :doorkeeper_authorize! # Requires access token for all actions

  def add_lab_machine_by_id
    # Your code here

    render json: {"message" => "yes, it worked"}
  end

  def create
    # Your code here

    render json: {"message" => "yes, it worked"}
  end

  def show
    # Your code here

    render json: {"message" => "yes, it worked"}
  end

  def get_lab_machines_by_id
    # Your code here

    render json: {"message" => "yes, it worked"}
  end

  def index
    @labs,@pagination = paginate Lab.with_approved_state.includes(:links)
    options = {}
    options[:meta] = {'total-pages' => @pagination['pages'] }
    options[:links] = @pagination

    render_json Api::V2::ApiLabsSerializer.new(@labs, options).serialized_json
  end

  def search_labs
    # Your code here

    render json: {"message" => "yes, it worked"}
  end

  def update
    # Your code here

    render json: {"message" => "yes, it worked"}
  end
end
