class LabAuthorizer < ApplicationAuthorizer

  def updatable_by?(user)
    user.has_role?(:admin) or
      (resource.approved? and user.verified? and user.has_role?(:admin, resource))
  end

  def readable_by?(user)
    resource.approved?
  end

  def self.creatable_by?(user)
    user.verified?
  end

  def self.deletable_by?(user)
    user.has_role?(:admin)
  end

end
