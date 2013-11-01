class RoleApplicationAuthorizer < ApplicationAuthorizer

  def self.creatable_by?(user)
    # user.resource
    # true
    # user.role_applications.include?
  end

end
