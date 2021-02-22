ActiveAdmin.register Project do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :type, :title, :description, :lab_id, :owner_id, :status, :version, :faq, :scope, :community, :lookingfor, :cover, :discourse_id, :discourse_errors, :slug, :visibility, :tag_list
  #
  # or
  #
  # permit_params do
  #   permitted = [:type, :title, :description, :lab_id, :owner_id, :status, :version, :faq, :scope, :community, :lookingfor, :cover, :discourse_id, :discourse_errors, :slug, :visibility, :tag_list]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  remove_filter :lab
  remove_filter :owner
  remove_filter :contribution
  remove_filter :contributors
  remove_filter :links
  remove_filter :collaborations
  remove_filter :collaborators
  remove_filter :machineries
  remove_filter :devices
  remove_filter :documents
  remove_filter :steps
  remove_filter :favourites
  remove_filter :grades
  remove_filter :users
  remove_filter :taggings
  remove_filter :base_tag
  remove_filter :base_tag
  remove_filter :tag_taggings
  remove_filter :tags
end
