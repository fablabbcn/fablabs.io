class FeaturedImageSerializer < ActiveModel::Serializer
  attributes :id, :src, :name, :description, :url
end
