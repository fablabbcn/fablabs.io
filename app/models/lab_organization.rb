class LabOrganization < ActiveRecord::Base
  belongs_to :lab, touch: true
  belongs_to :organization, touch: true

  STATES = [
    STATE_PENDING = 'pending',
    STATE_ACCEPTED = 'accepted'
  ]

  validates :workflow_state, inclusion: {in: STATES}
  validates :lab_id, uniqueness: { scope: :organization_id }

  scope :pending, -> {where(workflow_state: STATE_PENDING)}
  scope :accepted, -> {where(workflow_state: STATE_ACCEPTED)}

  def pending?
    workflow_state == STATE_PENDING
  end

  def accept!
    self.workflow_state = STATE_ACCEPTED
    self.save!
  end
end
