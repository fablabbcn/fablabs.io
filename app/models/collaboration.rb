class Collaboration < ActiveRecord::Base
  belongs_to :collaborator, class_name: 'Lab'
  belongs_to :project

end
