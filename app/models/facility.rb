class Facility < ActiveRecord::Base
  belongs_to :lab
  belongs_to :tool
  validates_presence_of :tool, :lab
end
