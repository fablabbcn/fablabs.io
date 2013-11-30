class Brand < ActiveRecord::Base

  include Authority::Abilities
  self.authorizer_name = 'ToolAuthorizer'

  validates_presence_of :name

  def to_s
    name
  end

end
