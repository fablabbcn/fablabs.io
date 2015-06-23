class ProjectAuthorizer < ApplicationAuthorizer

  def creatable_by?(user)
    true
  end

  def readable_by?(user)
    true
  end

  def updatable_by?(user)
    user == resource.owner or is_collaborator?(user)
  end

  def deletable_by?(user)
    user == resource.owner
  end

  def is_collaborator?(user)
    user == resource.collaborators.where(id: user.id)
  end

end
