class DiscussionSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :workflow_state
  has_one :discussable
  has_one :creator
end
