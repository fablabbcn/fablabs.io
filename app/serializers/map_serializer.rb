class MapSerializer < ActiveModel::Serializer

  attributes :id,
      :name,
      :slug,
      :latitude,
      :longitude,
      :url

  def url
    lab_url(object)
  end

end
