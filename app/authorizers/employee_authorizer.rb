class EmployeeAuthorizer < ApplicationAuthorizer

  def creatable_by?(user)
    resource.lab.approved? && user.verified? && !user.employed_by?(resource.lab)
  end

end
