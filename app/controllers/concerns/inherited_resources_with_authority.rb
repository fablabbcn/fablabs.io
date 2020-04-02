module InheritedResourcesWithAuthority
  extend ActiveSupport::Concern

  included do
    inherit_resources
    authorize_actions_for :resource_class

    # TODO: Do we need this file?
    # TODO: alias_method_chain is deprecated. Use Module#prepend instead
    alias_method :resource_without_authority, :resource
    alias_method :resource, :resource_with_authority

    alias_method :build_resource_without_authority, :build_resource
    alias_method :build_resource, :build_resource_with_authority

    alias_method :update_resource_without_authority, :update_resource
    alias_method :update_resource, :update_resource_with_authority
  end

  protected

  def resource_with_authority
    resource_without_authority
    authorize_action_for(get_resource_ivar)
    get_resource_ivar
  end

  def build_resource_with_authority
    build_resource_without_authority
    get_resource_ivar
  end

  def update_resource_with_authority(object, attributes)
    object.assign_attributes(*attributes)
    authorize_action_for(object)
    object.save
  end

end
