class EmployeeAuthorizer < ApplicationAuthorizer

  def creatable_by?(user)
    resource.lab.approved? and
      user.verified? and
      !user.applied_to?(resource.lab)
  end

  def updatable_by?(user)
    user.has_role?(:admin) or (resource.lab.approved? and
      user.verified? and
      user.applied_to?(resource.lab))
  end

end
