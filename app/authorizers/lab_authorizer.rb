class LabAuthorizer < ApplicationAuthorizer

  def readable_by?(user)
    resource.approved? || user.has_role?(:admin)
  end

  def self.deletable_by?(user)
    user.has_role? :admin
  end

  def self.creatable_by?(user)
    user.persisted?
  end

end
