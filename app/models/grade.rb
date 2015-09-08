class Grade < ActiveRecord::Base
  belongs_to :user
  belongs_to :project

  validates_inclusion_of :stars, :in => 0..5
end
