class Activity < ActiveRecord::Base
  belongs_to :user
  belongs_to :trackable, polymorphic: true
  default_scope -> { order(id: :desc).includes(:user, :trackable) }

  def actioned
    "#{action}ed".gsub(/ed?ed$/, 'ed')
  end

end
