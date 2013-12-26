class EventSerializer < ActiveModel::Serializer
  attributes :id, :type, :name, :description, :starts_at, :ends_at
  has_one :lab
  has_one :creator
end
