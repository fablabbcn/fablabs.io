class Facility < ActiveRecord::Base
  belongs_to :lab, touch: true
  belongs_to :thing, touch: true
  validates_presence_of :thing, :lab
end
