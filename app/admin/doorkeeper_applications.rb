ActiveAdmin.register Doorkeeper::Application do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :name, :redirect_uri, :scopes, :confidential
  #
  # or
  #
  # permit_params do
  #   permitted = [:name, :uid, :secret, :redirect_uri, :scopes, :owner_id, :owner_type, :confidential]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  remove_filter :access_grants
  remove_filter :access_tokens
  remove_filter :authorized_tokens
  remove_filter :authorized_applications

  index do
    selectable_column
    id_column
    column :name
    column :redirect_uri
    column :owner
    column :owner_type
    column :scopes
    column :confidential
    column :created_at
    column :updated_at
    actions
  end
end
