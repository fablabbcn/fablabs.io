class Job < ApplicationRecord
  belongs_to :user
  acts_as_taggable_on :tags

  def self.recent
    where("updated_at > ?", 90.days.ago)
  end
end
