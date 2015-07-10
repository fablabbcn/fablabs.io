class Step < ActiveRecord::Base
  belongs_to :project
  has_many :links, as: :linkable

  
end
