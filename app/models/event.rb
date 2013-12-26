class Event < ActiveRecord::Base

  include Authority::Abilities
  self.authorizer_name = 'EventAuthorizer'

  belongs_to :lab
  belongs_to :creator, class_name: 'User'
  validates_presence_of :name, :description, :starts_at, :lab

  def to_s
    name
  end

  def all_day?
    starts_at == starts_at.beginning_of_day
  end

end
