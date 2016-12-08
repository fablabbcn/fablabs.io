class Organizations::LabOrganizationsController < ApplicationController

  before_filter :require_superadmin # just during testing
  before_filter :find_organization
  include LabsSearch

  def new
    find_lab if params[:lab_id].present?

    unless @lab
      @labs = search_labs(params[:query]|| '').page(params[:page])
    end
  end

  def create
    find_lab
    @lab_organization = @organization.lab_organizations.create(lab: @lab)
    redirect_to @organization
  end

  private

  def find_organization
    @organization = Organization.friendly.find(params[:organization_id])
  end

  def find_lab
    @lab = Lab.friendly.find(params[:lab_id])
  end
end
