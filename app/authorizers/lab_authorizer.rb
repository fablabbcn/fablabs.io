class LabAuthorizer < ApplicationAuthorizer

  def updatable_by?(user)
    user.has_role?(:admin, resource) or (resource.approved? and user.verified? and user.employed_by?(resource))
  end

  def deletable_by?(user)
    false
    # user.verified? and user.has_role?(:admin)
  end

  def readable_by?(user)
    resource.approved?
  end

  def self.creatable_by?(user)
    user.verified?
  end

end
