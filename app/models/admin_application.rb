class AdminApplication < ActiveRecord::Base
  belongs_to :applicant
  belongs_to :lab
  validates_presence_of :applicant, :lab
end
