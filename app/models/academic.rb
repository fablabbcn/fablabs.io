class Academic < ActiveRecord::Base
  belongs_to :user
  belongs_to :lab
  belongs_to :approver

  validates_presence_of :started_in, :lab, :user
end
