class Lab < ActiveRecord::Base

  validates :name, :description, presence: true
  belongs_to :creator, class_name: 'User'

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
