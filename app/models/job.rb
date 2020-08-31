class Job < ApplicationRecord
  belongs_to :user
  acts_as_taggable_on :tags

end
