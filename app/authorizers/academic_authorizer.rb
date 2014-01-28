class AcademicAuthorizer < ApplicationAuthorizer

  def self.creatable_by?(user)
    user.has_role? :academy
  end

  def self.updatable_by?(user)
    user.has_role? :academy
  end

  def self.readable_by?(user)
    user.has_role? :academy
  end

  def self.deletable_by?(user)
    user.has_role? :academy
  end

end
