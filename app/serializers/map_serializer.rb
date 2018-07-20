class MapSerializer < ActiveModel::Serializer

  attributes :id,
      :name,
      :slug,
      :latitude,
      :longitude,
      :url,
      :kind_name

  def url
    lab_url(object)
  end

  def kind_name
    kind
  end

end
