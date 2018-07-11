class OrganizationsController < ApplicationController

  before_filter :require_login, only: [:new, :create, :update, :edit]

  def index
    @organizations = Organization.approved
      .order(order: :asc).order(name: :asc)
      .page(params[:page])
  end

  def new
    @organization = current_user.created_organizations.build
  end

  def create
    @organization = current_user.created_organizations.new(organization_params)
    if @organization.save
      redirect_to organization_path(@organization), notice: 'Organization created'
    else
      render :new
    end
  end

  def show
    find_organization
  end

  def edit
    find_organization
  end

  def update
    find_organization
    if @organization.update(organization_params)
      redirect_to organization_path(@organization), notice: 'Organization updated'
    else
      render :edit
    end
  end

  private

  def find_organization
    @organization = Organization.friendly.find(params[:id])
  end

  def organization_params
    attributes = [:name,
      :description,
      :kind,
      :blurb,
      :avatar,
      :header,
      :phone,
      :email,
      :latitude,
      :longitude,
      :geocomplete,
      :address_1,
      :address_2,
      :city,
      :county,
      :postal_code,
      :country_code,
      :address_notes,
      :application_notes,
      links_attributes: [ :id, :link_id, :url, '_destroy' ]
    ]

    if current_user.has_role?(:superadmin)
      attributes.push(:workflow_state, :geojson, :geojson_file, :zoom)
    end

    params.require(:organization).permit(attributes)
  end
end
