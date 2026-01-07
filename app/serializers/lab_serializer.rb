# frozen_string_literal: true

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
             :header_url,
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
             :activity_status
  #:url
  # :links,
  # :employees
  # links_attributes: [ :id, :link_id, :url, '_destroy' ],
  # employees_attributes: [ :id, :job_title, :description ]

  has_many :links

  # TODO: kind_name is breaking labs.json endpoint. Temporary comment out
  def kind_name
    object.kind || Lab::KINDS[1]
  end

  def url
    lab_url(object)
  end

  def avatar_url
    # Only return url if there is an actual avatar (no default image needed in api)
    if object.avatar_uid.present?
      object.avatar.thumb('150x150#').url(host: 'https://www.fablabs.io')
    end
  end

  def header_url
    # Only return url if there is an actual header (no default image needed in api)
    if object.header.present?
      object.header.thumb("800x").url(host: 'https://www.fablabs.io')
    end
  end

  # def cache_key
  #   # object
  #   # [object, scope]
  # end
end
