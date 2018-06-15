class Api::V2::LabsController < Api::V2::ApiController
  before_action :dorkeeper_authorize!
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
    # Your code here

    render json: {"message" => "yes, it worked"}
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
