class Facility < ActiveRecord::Base
  belongs_to :lab
  belongs_to :thing, polymorphic: true
  validates_presence_of :thing, :lab
end
