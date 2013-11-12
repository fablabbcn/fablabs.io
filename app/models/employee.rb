class Employee < ActiveRecord::Base
  belongs_to :user
  belongs_to :lab
  validates_presence_of :user, :lab
  validates_uniqueness_of :user_id, scope: :lab_id

  include Workflow
  workflow do
    state :unverified do
      event :approve, transitions_to: :approved
    end
    state :approved
  end

end
