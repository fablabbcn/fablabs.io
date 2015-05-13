class Contribution < ActiveRecord::Base
  belongs_to :contributor, class_name: 'User'
  belongs_to :project
end
