class Image < ActiveRecord::Base
  belongs_to :project
  attachment :file
end
