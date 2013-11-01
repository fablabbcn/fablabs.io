class RoleApplication < ActiveRecord::Base
  belongs_to :user
  belongs_to :lab
  validates_presence_of :lab
  validates_presence_of :user
  validates_presence_of :description
  include Authority::Abilities
  self.authorizer_name = 'RoleApplicationAuthorizer'
end
