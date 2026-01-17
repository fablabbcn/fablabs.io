class AdminApplication < ApplicationRecord
  belongs_to :applicant, class_name: 'User'
  belongs_to :lab, class_name: 'Lab'
  validates_presence_of :applicant, :lab
end
