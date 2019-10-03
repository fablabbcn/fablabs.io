class Employee < ActiveRecord::Base
  include Authority::Abilities
  self.authorizer_name = 'EmployeeAuthorizer'

  belongs_to :user, touch: true
  belongs_to :lab, touch: true
  validates_presence_of :user, :lab, :job_title, :description
  validates_uniqueness_of :user_id, scope: :lab_id

  after_create :auto_approve_for_admins
  before_destroy { user.revoke :admin, lab }

  scope :active, -> { includes(:user).with_approved_state.references(:user) }

  include Workflow
  workflow do
    state :unverified do
      event :approve, transitions_to: :approved
    end
    state :approved
  end

  def approve
    user.add_role :admin, lab
  end

private

  def auto_approve_for_admins
    approve! if user.present? and user.has_role?(:admin, lab)
  end

end
