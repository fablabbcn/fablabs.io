class RoleApplicationSerializer < ActiveModel::Serializer
  attributes :id, :workflow_state, :description
  has_one :user
  has_one :lab
end
