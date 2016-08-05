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
      owner: owner(object.owner),
      users: [owner(object.owner), collaborations, contributions].flatten,
      lab: lab
    }
  end

  def documents
    if object.documents.any?
      object.documents.map {|d| d.image.url(:medium) }
    end
  end

  def collaborations
    if object.collaborations.any?
      object.collaborations.map {|c| c.collaborator }
    end
  end

  def contributions
    if object.contributions.any?
      object.contributions.map {|c| c.contributor }
    end
  end

  def lab
    {
      name: object.lab.name,
      kind: object.lab.kind_name,
      slug: object.lab.slug,
      avatar: object.lab.avatar
    }
  end

  def owner(user)
    {
      id: user.id,
      full_name: user.full_name,
      avatar: user.avatar
    }
  end

  def type
    "projects"
  end

end
