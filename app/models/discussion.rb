class Discussion < ActiveRecord::Base
  belongs_to :discussable, polymorphic: true
  belongs_to :creator
end
