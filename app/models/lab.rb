class Lab < ActiveRecord::Base
  resourcify
  include Authority::Abilities
  self.authorizer_name = 'LabAuthorizer'

  belongs_to :creator, class_name: 'User'
  validates :name, :description, :creator, presence: true
  validates_uniqueness_of :name

  def to_s
    name
  end

  include Workflow
  workflow do
    state :unverified do
      event :approve, transitions_to: :approved
      event :reject, transitions_to: :rejected
    end
    state :approved
    state :rejected
  end

end
