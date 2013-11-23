class Employee < ActiveRecord::Base
  belongs_to :user
  belongs_to :lab
  validates_presence_of :user, :lab, :job_title
  validates_uniqueness_of :user_id, scope: :lab_id

  include Authority::Abilities
  self.authorizer_name = 'EmployeeAuthorizer'

  scope :active, -> { includes(:user).with_approved_state.order('LOWER(users.last_name) ASC') }

  include Workflow
  workflow do
    state :unverified do
      event :approve, transitions_to: :approved
    end
    state :approved
  end

end
