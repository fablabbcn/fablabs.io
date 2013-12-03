class LabAuthorizer < ApplicationAuthorizer

  def updatable_by?(user)
    user.has_role?(:superadmin) or
      (resource.approved? and user.has_role?(:admin, resource))
  end

  def readable_by?(user)
    resource.approved?
  end

  def self.creatable_by?(user)
    true
  end

  def self.deletable_by?(user)
    user.has_role?(:superadmin)
  end

end
