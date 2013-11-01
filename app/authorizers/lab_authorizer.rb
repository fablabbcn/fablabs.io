class LabAuthorizer < ApplicationAuthorizer

  def readable_by?(user)
    resource.approved? || user.has_role?(:admin, resource)
  end

  def updatable_by?(user)
    user.has_role? :admin, resource
  end

  def deletable_by?(user)
    user.has_role? :admin
  end

  def self.creatable_by?(user)
    user.verified?
  end

  def applyable_by?(user)
    !user.created_labs.include?(resource) and
    !user.role_applications.where(lab: resource).exists? and
    !user.has_role? :admin
  end

end
