class Comment < ActiveRecord::Base
  belongs_to :author, class_name: 'User'
  belongs_to :commentable, polymorphic: true
  validates_presence_of :author, :commentable
  has_ancestry
end
