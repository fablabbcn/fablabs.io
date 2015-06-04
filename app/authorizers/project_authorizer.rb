class ProjectAuthorizer < ApplicationAuthorizer

  def creatable_by?(user)
    true
  end

  def readable_by?(user)
    true
  end

  def updatable_by?(user)
    user == resource.owner
  end

  def deletable_by?(user)
    user == resource.owner
  end

end
