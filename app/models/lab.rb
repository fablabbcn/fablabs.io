class Lab < ActiveRecord::Base
  validates :name, :description, presence: true
  belongs_to :creator, class_name: 'User'

  def to_s
    name
  end

end
