ActiveAdmin.register Organization do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :name, :description, :creator_id, :slug, :kind, :blurb, :phone, :email, :application_notes, :discourse_id, :discourse_errors, :workflow_state, :geojson, :latitude, :longitude, :zoom, :address_1, :address_2, :city, :county, :postal_code, :country_code, :subregion, :region, :address_notes, :reverse_geocoded_address, :avatar_uid, :avatar_name, :header_uid, :header_name, :order
  #
  # or
  #
  # permit_params do
  #   permitted = [:name, :description, :creator_id, :slug, :kind, :blurb, :phone, :email, :application_notes, :discourse_id, :discourse_errors, :workflow_state, :geojson, :latitude, :longitude, :zoom, :address_1, :address_2, :city, :county, :postal_code, :country_code, :subregion, :region, :address_notes, :reverse_geocoded_address, :avatar_uid, :avatar_name, :header_uid, :header_name, :order]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  filter :name
  filter :slug
  filter :description
  filter :workflow_state
  
  remove_filter :labs
  remove_filter :lab_organizations
  remove_filter :links
  remove_filter :creator
end
