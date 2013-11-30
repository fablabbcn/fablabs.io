class EmployeeAuthorizer < ApplicationAuthorizer

  def creatable_by?(user)
    resource.lab.approved? and
      user.verified? and
      !user.applied_to?(resource.lab)
  end

end
