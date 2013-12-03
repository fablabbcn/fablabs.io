class EmployeeAuthorizer < ApplicationAuthorizer

  def readable_by?(user)
    user.has_role?(:superadmin) or user.has_role?(:admin, resource.lab)
  end

  def creatable_by?(user)
    user.has_role?(:superadmin) or
    (resource.lab.approved?)
  end

  def updatable_by?(user)
    user.has_role?(:superadmin) or (resource.lab.approved? and
      user.applied_to?(resource.lab))
  end

end
