class Page < ActiveRecord::Base
  belongs_to :pageable, polymorphic: true
  belongs_to :creator

  validates_presence_of :name, :body, :creator, :pageable

end
