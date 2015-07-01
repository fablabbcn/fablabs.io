class Machinery < ActiveRecord::Base
  belongs_to :device, class_name: 'Machine'
  belongs_to :project
end
