class Lab < ActiveRecord::Base
  resourcify
  include Authority::Abilities
  self.authorizer_name = 'LabAuthorizer'

  belongs_to :creator, class_name: 'User'
  validates :name, :description, presence: true
  validates_presence_of :creator, on: :create
  validates_uniqueness_of :name, case_sensitive: false

  after_create :notify_everyone

  def approve
    UserMailer.lab_approved(self).deliver
  end

  def to_s
    name
  end

  include Workflow
  workflow do
    state :unverified do
      event :approve, transitions_to: :approved
      # event :reject, transitions_to: :rejected
    end
    state :approved
    state :rejected
  end

  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged

  def slug_candidates
    [
      :name
    ]
  end

private

  def notify_everyone
    UserMailer.lab_submitted(self).deliver
    AdminMailer.lab_submitted(self).deliver
  end

end
