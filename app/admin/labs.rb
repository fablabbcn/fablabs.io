ActiveAdmin.register Lab do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :name, :slug, :description, :ancestry, :creator_id, :workflow_state, :capabilities, :time_zone, :phone, :email, :address_1, :address_2, :city, :county, :postal_code, :country_code, :subregion, :region, :latitude, :longitude, :zoom, :address_notes, :reverse_geocoded_address, :kind, :application_notes, :tools_list, :blurb, :referee_id, :network, :programs, :tools, :charter, :public, :discourse_id, :discourse_errors, :is_referee, :avatar_uid, :avatar_name, :header_uid, :header_name, :activity_status, :activity_start_at, :activity_inaugurated_at, :activity_closed_at, :improve_approval_application
  #
  # or
  #
  # permit_params do
  #   permitted = [:name, :slug, :description, :ancestry, :creator_id, :workflow_state, :capabilities, :time_zone, :phone, :email, :address_1, :address_2, :city, :county, :postal_code, :country_code, :subregion, :region, :latitude, :longitude, :zoom, :address_notes, :reverse_geocoded_address, :kind, :application_notes, :tools_list, :blurb, :referee_id, :network, :programs, :tools, :charter, :public, :discourse_id, :discourse_errors, :is_referee, :avatar_uid, :avatar_name, :header_uid, :header_name, :activity_status, :activity_start_at, :activity_inaugurated_at, :activity_closed_at, :improve_approval_application]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  filter :slug
  filter :name
  filter :city
  filter :country_code
  filter :activity_status, as: :select
  filter :workflow_state, as: :select
  filter :is_referee
  filter :kind, as: :select

  scope :all
  scope :approved
  scope :approved_referees
  scope :pending
  scope :unverified

  remove_filter :roles
  remove_filter :academics
  remove_filter :admin_applications
  remove_filter :events
  remove_filter :discussions
  remove_filter :employees
  remove_filter :links
  remove_filter :role_applications
  remove_filter :facilities
  remove_filter :projects
  remove_filter :documents
  remove_filter :creator
  remove_filter :referee
  remove_filter :organizations
  remove_filter :lab_organizations
  remove_filter :referee_approval_processes
  remove_filter :approval_workflow_logs
end
