class Activity < ActiveRecord::Base
  belongs_to :creator, class_name: 'User'
  belongs_to :actor, class_name: 'User'

  belongs_to :trackable, polymorphic: true
  default_scope -> { order(id: :desc).includes(:actor, :creator, :trackable) }

  def actioned
    "#{action}ed".gsub(/ed?ed$/, 'ed')
  end

end
