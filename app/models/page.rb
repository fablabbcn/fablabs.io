class Page < ActiveRecord::Base
  validates :title, presence: true
  validates :slug, presence: true, length: { minimum: 3 }, uniqueness: { case_sensitive: false}

  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged

  def slug_candidates
    [:title]
  end

  def should_generate_new_friendly_id?
    new_record?
  end


end
