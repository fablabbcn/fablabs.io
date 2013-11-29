class Link < ActiveRecord::Base
  belongs_to :linkable, polymorphic: true
  # validates_presence_of :lab
  validates_presence_of :url
  validates_uniqueness_of :url, scope: [:linkable_id, :linkable_type]
  validates_format_of :url, with: URI::regexp(%w(http https))
  before_validation :add_http

  scope :twitter_urls, -> { where("url ~* 'twitter.com/'").map(&:url) }

private

  def add_http
    self.url = "http://#{url}" if url.present? and !url.match(/^http/)
  end

end
