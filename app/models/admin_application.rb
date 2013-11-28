class AdminApplication < ActiveRecord::Base
  belongs_to :applicant
  belongs_to :lab
end
