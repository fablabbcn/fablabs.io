module InheritedResourcesWithAuthority

  extend ActiveSupport::Concern

  included do
    inherit_resources
    authorize_actions_for :resource_class

    alias_method_chain :resource, :authority
    alias_method_chain :build_resource, :authority
    alias_method_chain :update_resource, :authority
  end

  protected

  def resource_with_authority
    resource_without_authority
    authorize_action_for(get_resource_ivar)
  end

  def build_resource_with_authority
    build_resource_without_authority
    authorize_action_for(get_resource_ivar)
  end

  def update_resource_with_authority(object, attributes)
    object.assign_attributes(*attributes)
    authorize_action_for(object)
    object.save
  end

end
