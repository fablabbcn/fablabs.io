class Favourite < ActiveRecord::Base
  belongs_to :user
  belongs_to :project
  validates :user_id, uniqueness: { scope: :project_id }

end
