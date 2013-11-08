class Tool < ActiveRecord::Base
  belongs_to :brand
  validates_presence_of :name

  def to_s
    name
  end
end
