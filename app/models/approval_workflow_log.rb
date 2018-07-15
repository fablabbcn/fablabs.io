class ApprovalWorkflowLog < ActiveRecord::Base
  validates :lab_id, presence: true
  validates :user_id, presence: true
  validates :workflow_state, presence: true

  belongs_to :lab
  belongs_to :user
end
