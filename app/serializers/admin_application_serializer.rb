class AdminApplicationSerializer < ActiveModel::Serializer
  attributes :id, :notes, :workflow_state
  has_one :applicant
  has_one :lab
end
