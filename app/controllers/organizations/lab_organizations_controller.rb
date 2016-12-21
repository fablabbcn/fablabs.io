class Organizations::LabOrganizationsController < ApplicationController

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
    @lab_organization = @organization.lab_organizations.create(lab: @lab, workflow_state: LabOrganization::STATE_PENDING)
    UserMailer.delay.lab_organization_accept(@lab_organization_accept.id)
    redirect_to @organization
  end

  def show
    find_lab_organization
  end

  def accept
    find_lab_organization
    if current_user == @lab_organization.lab.creator
      @lab_organization.accept!
    else
      flash[:notice] = 'Unauthorized user'
    end
    redirect_to organization_lab_organization_path(@organization, @lab_organization)
  end

  private

  def find_lab_organization
    @lab_organization = @organization.lab_organizations.find(params[:id])
  end

  def find_organization
    @organization = current_user.created_organizations.friendly.find(params[:organization_id])
  end

  def find_lab
    @lab = Lab.friendly.find(params[:lab_id])
  end
end
