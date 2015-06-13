class Project < ActiveRecord::Base
  include Authority::UserAbilities
  include Authority::Abilities
  include RocketPants::Cacheable

  self.authorizer_name = 'ProjectAuthorizer'

  belongs_to :lab
  belongs_to :owner, class_name: 'User'

  has_many :contributions, dependent: :destroy
  has_many :contributors, through: :contributions

  accepts_nested_attributes_for :contributions

  def self.last_updated_at
    self.select(:updated_at).order('updated_at DESC').first
  end

end
