class Lab < ActiveRecord::Base
  validates :name, :description, presence: true

  def to_s
    name
  end

end
