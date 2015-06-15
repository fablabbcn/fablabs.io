class Machinery < ActiveRecord::Base
  belongs_to :device, class_name: 'Thing'
  belongs_to :project
end
