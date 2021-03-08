ActiveAdmin.register RefereeApprovalProcess do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :referred_lab_id, :referee_lab_id, :approved
  #
  # or
  #
  # permit_params do
  #   permitted = [:referred_lab_id, :referee_lab_id, :approved]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  scope :all
  scope :approved
end
