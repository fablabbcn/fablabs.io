class LabAuthorizer < ApplicationAuthorizer

  def updatable_by?(user)
    user.has_role?(:superadmin) or user.has_role?(:admin, resource) or user.is_creator? resource
  end

  def readable_by?(user)
    resource.approved? or user.has_role?(:admin, resource) or user.is_creator? resource
  end

  def self.creatable_by?(user)
    true
  end

  def self.deletable_by?(user)
    user.has_role?(:superadmin)
  end

end
