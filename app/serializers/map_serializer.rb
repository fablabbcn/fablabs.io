class MapSerializer < ActiveModel::Serializer

  attributes :id,
      :name,
      :latitude,
      :longitude

end
