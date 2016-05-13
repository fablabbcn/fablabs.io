class LabJsonapiSerializer < ActiveModel::Serializer
  attributes :id, :type, :meta, :links, :relationships
  attribute :data, key: :attributes

  def data
    {
      name: object.name,
      kind: object.kind_name,
      slug: object.slug,
      description: object.description,
      avatar: object.avatar_src,
      header: object.header_image_src,
      location: location,
      contacts: contacts
    }
  end

  def type
    "labs"
  end

  def contacts
    {
      phone: :phone,
      email: :email,
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
      self: "https://api.fablabs.io/v1/#{object.slug}/",
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
