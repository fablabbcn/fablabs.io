class Brand < ActiveRecord::Base

  include Authority::Abilities
  self.authorizer_name = 'ThingAuthorizer'

  validates_presence_of :name

  def to_s
    name
  end

end
