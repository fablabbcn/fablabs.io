class LabSerializer < ActiveModel::Serializer

  # cached

  attributes :id,
    :name,
    :kind_name,
    :parent_id,
    :blurb,
    :description,
    :slug,
    :avatar_url,
    :header_image_src,
    :address_1,
    :address_2,
    :city,
    :county,
    :postal_code,
    :country_code,
    :latitude,
    :longitude,
    :address_notes,
    :phone,
    :email,
    :capabilities,
    :url
    # :links,
    # :employees
    # links_attributes: [ :id, :link_id, :url, '_destroy' ],
    # employees_attributes: [ :id, :job_title, :description ]

  has_many :links

  def kind_name
    Lab::Kinds[object.kind]
  end

  def url
    lab_url(object)
  end

  def avatar_url
    Dragonfly.app.remote_url_for(object.avatar_uid)
  end

  # def cache_key
  #   # object
  #   # [object, scope]
  # end

end
