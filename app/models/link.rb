class Link < ActiveRecord::Base
  belongs_to :lab
  # validates_presence_of :lab
  validates_presence_of :url
  validates_format_of :url, with: URI::regexp(%w(http https))
end
