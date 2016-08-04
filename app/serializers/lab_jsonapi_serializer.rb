class LabJsonapiSerializer < ActiveModel::Serializer
  attributes :id, :type, :meta, :links, :relationships
  attribute :data, key: :attributes

  def data
    {
      name: object.name,
      kind: object.kind_name,
      slug: object.slug,
      description: object.description,
      avatar: object.avatar,
      header: object.header,
      location: location,
      contacts: contacts,
      capabilities: object.capabilities,
      machines: object.machines,
      projects: projects,
      users: users
    }
  end

  def type
    "labs"
  end

  def users
    object.employees.map { |user| Hash[ user_attributes(user) ] }
  end

  def user_attributes(user)
    {
      id: user.id,
      job_title: user.job_title,
      full_name: user.full_name, 
      avatar: user.avatar_src
    }
  end

  def projects
    object.projects.map { |project|  Hash[ project_attributes(project) ] }
  end

  def project_attributes(project)
    {
      id: project.id,
      title: project.title,
      description: project.description,
      faq: project.faq,
      github: project.github,
      web: project.web,
      dropbox: project.dropbox,
      bitbucket:   project.bitbucket,
      created_at: project.created_at,
      updated_at: project.updated_at,
      vimeo: project.vimeo,
      flickr: project.flickr,
      youtube: project.youtube,
      drive: project.drive,
      twitter: project.twitter,
      facebook: project.facebook,
      googleplus: project.googleplus,
      instagram: project.instagram,
      status: project.status,
      version: project.version,
      scope: project.scope,
      community: project.community,
      lookingfor: project.lookingfor,
      cover: project.project_cover,
      documents: project.documents,
      owner: project.owner
    }
  end

  def contacts
    {
      phone: object.phone,
      email: object.email,
    }
  end

  def location
    {
      time_zone: object.time_zone,
      address_1: object.address_1,
      address_2: object.address_2,
      city: object.city,
      country: object.country,
      postal_code: object.postal_code,
      country_code: object.country_code,
      subregion: object.subregion,
      region: object.region,
      latitude: object.latitude,
      longitude: object.longitude,
      zoom: object.zoom,
      address_notes: object.address_notes,
      reverse_geocoded_address: object.reverse_geocoded_address,
    }
  end

  def meta
    {
      workflow_state: object.workflow_state,
      created_at: object.created_at,
      updated_at: object.updated_at,
      blurb: object.blurb
    }
  end

  def links
    {
      self: "https://api.fablabs.io/api/v1/#{object.slug}/",
      related: object.links
    }
  end

  def relationships
    {
      unique_referee:
        {
          referee_id: object.referee_id
        },
      referees:
        [

        ]
    }
  end


end
