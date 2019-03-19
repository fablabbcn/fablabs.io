class Organizations::LabOrganizationsController < ApplicationController

  before_filter :find_organization
  before_filter :check_creator, only: [:new, :create]

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
    UserMailer.lab_organization_accept(@lab_organization.id).deliver_now
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

  def check_creator
    unless @organization.creator == current_user
      redirect_to root_path
    end
  end

  def find_lab_organization
    @lab_organization = @organization.lab_organizations.find(params[:id])
  end

  def find_organization
    @organization = Organization.friendly.find(params[:organization_id])
  end

  def find_lab
    @lab = Lab.friendly.find(params[:lab_id])
  end
end
