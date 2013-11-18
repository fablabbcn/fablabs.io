class Tool < ActiveRecord::Base
  belongs_to :brand
  validates_presence_of :name
  has_many :discussions, as: :discussable
  has_many :facilities, as: :thing
  has_many :labs, through: :facilities

  acts_as_taggable

  def to_s
    name
  end
end
