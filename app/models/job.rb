class Job < ApplicationRecord
  belongs_to :user
  acts_as_taggable_on :tags

  def self.recent
    where("updated_at > ?", 90.days.ago)
  end

  def self.ransackable_attributes(auth_object = nil)
    ['id', 'title', 'description', 'country_code']
  end

  def self.ransackable_associations(auth_object = nil)
    %w[tags]
  end
end
