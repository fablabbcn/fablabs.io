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
  
end
