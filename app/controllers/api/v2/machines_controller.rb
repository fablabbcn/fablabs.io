class Api::V2::MachinesController < Api::V2::ApiController

  before_action :doorkeeper_authorize!

  def create
    render_json not_implemented

  end

  def show
    render_json not_implemented

  end

  def index
    render_json not_implemented

  end

  def update
    render_json not_implemented

  end
end
