class Grade < ActiveRecord::Base
  belongs_to :user
  belongs_to :project
  validates :user_id, uniqueness: { scope: :project_id }
  validates_inclusion_of :stars, :in => 0..5
end
