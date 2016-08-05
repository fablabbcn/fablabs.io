class ProjectJsonapiSerializer < ActiveModel::Serializer
  attributes :id, :type
  attribute :data, key: :attributes

  def data
    {
      title: object.title,
      description: object.description,
      faq: object.faq,
      github: object.github,
      web: object.web,
      dropbox: object.dropbox,
      bitbucket:   object.bitbucket,
      created_at: object.created_at,
      updated_at: object.updated_at,
      vimeo: object.vimeo,
      flickr: object.flickr,
      youtube: object.youtube,
      drive: object.drive,
      twitter: object.twitter,
      facebook: object.facebook,
      googleplus: object.googleplus,
      instagram: object.instagram,
      status: object.status,
      version: object.version,
      scope: object.scope,
      community: object.community,
      lookingfor: object.lookingfor,
      cover: object.project_cover,
      documents: documents,
      steps: object.steps,
      owner: user(object.owner),
      users: [user(object.owner), contributions].flatten,
      collaborations: collaborations,
      lab: lab(object.lab)
    }
  end

  def documents
    if object.documents.any?
      object.documents.map {|d| d.image.url(:medium) }
    end
  end

  def collaborations
    if object.collaborations.any?
      object.collaborations.map {|c| lab(c.collaborator) }
    end
  end

  def contributions
    if object.contributions.any?
      object.contributions.map {|c| user(c.contributor) }
    end
  end

  def lab(l)
    {
      name: l.name,
      kind: l.kind_name,
      slug: l.slug,
      avatar: l.avatar
    }
  end

  def user(u)
    {
      id: u.id,
      full_name: u.full_name,
      avatar: u.avatar
    }
  end

  def type
    "projects"
  end

end
