class Api::V2::OrganizationsController < Api::V2::ApiController

  before_action :doorkeeper_authorize!


  def create
    render_json not_implemented

  end

  def get_organization_labs_by_id
    render_json not_implemented

  end

  def show
    @organization = Organization.friendly.find(params[:id])
    expose @organization
  end

  def index
    render_json not_implemented

  end

  def update
    render_json not_implemented

  end

  def update_organization_lab_by_id
    render_json not_implemented

  end
end
