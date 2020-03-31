# frozen_string_literal: true

class MapSerializer < ActiveModel::Serializer
  attributes :id,
             :name,
             # TODO: disabling slug because it breaks http://api.fablabs.local:3000/0/labs/map with 'missing attribute'
             :slug,
             :latitude,
             :longitude,
            #  :url,
             :kind_name,
             :status

  def url
    lab_url(object)
  end

  def latitude
    object.latitude&.round(2)
  end

  def longitude
    object.longitude&.round(2)
  end

  def status
    object.activity_status || "unknown"
  end

  def kind_name
    object.kind || Lab::KINDS[1]
  end
end
