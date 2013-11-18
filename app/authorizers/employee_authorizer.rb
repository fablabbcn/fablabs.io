class EmployeeAuthorizer < ApplicationAuthorizer

  def creatable_by?(user)
    # resource.lab.approved? and
    !user.employed_by? resource.lab
  end

end
