class ToolAuthorizer < ApplicationAuthorizer

  def self.creatable_by?(user)
    user.has_role? :admin
  end

  def self.readable_by?(user)
    true
  end

end
