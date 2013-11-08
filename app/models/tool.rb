class Tool < ActiveRecord::Base
  belongs_to :brand
  validates_presence_of :name
  has_many :facilities
  has_many :labs, through: :facilities

  def to_s
    name
  end
end
