ActiveAdmin.register Machine do
  config.per_page = [50, 100, 300]

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :name, :brand_id, :description, :workflow_state, :ancestry, :creator_id, :type, :inventory_item, :discourse_id, :discourse_errors, :photo_uid, :photo_name, :slug, :tag_list
  #
  # or
  #
  # permit_params do
  #   permitted = [:name, :brand_id, :description, :workflow_state, :ancestry, :creator_id, :type, :inventory_item, :discourse_id, :discourse_errors, :photo_uid, :photo_name, :slug, :tag_list]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  remove_filter :brand
  remove_filter :discussions
  remove_filter :facilities
  remove_filter :labs
  remove_filter :links
  remove_filter :documents
  remove_filter :taggings
  remove_filter :base_tags
  remove_filter :tag_taggings
  remove_filter :tags

end
