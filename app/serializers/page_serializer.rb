class PageSerializer < ActiveModel::Serializer
  attributes :id, :ancestry, :name, :body
  has_one :pageable
  has_one :creator
end
