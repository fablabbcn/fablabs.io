class Project < ActiveRecord::Base
  include Authority::UserAbilities
  include Authority::Abilities
  include RocketPants::Cacheable

  before_save :assign_to_lab, :strip_zeroes

  self.authorizer_name = 'ProjectAuthorizer'

  belongs_to :lab
  belongs_to :owner, class_name: 'User'

  has_many :contributions, dependent: :destroy
  has_many :contributors, through: :contributions
  accepts_nested_attributes_for :contributions

  has_many :collaborations, dependent: :destroy
  has_many :collaborators, through: :collaborations
  accepts_nested_attributes_for :collaborations

  has_many :machineries, dependent: :destroy
  has_many :devices, through: :machineries
  accepts_nested_attributes_for :machineries

  has_many :documents, dependent: :destroy
  accepts_nested_attributes_for :documents

  has_many :steps, dependent: :destroy
  accepts_nested_attributes_for :steps, allow_destroy: true

  validates :title, presence: true, allow_blank: false

  acts_as_taggable

  def self.last_updated_at
    self.select(:updated_at).order('updated_at DESC').first
  end

  def setted_tags
    [ "Fab Academy Final Project",
      "Fab Academy Diploma Thesis",
      "Fab Awards 14",
      "Fab Awards 15",
      "Software",
      "Hardware",
      "OpenSource",
      "Furniture",
      "Architecture"
    ]
  end

  private
    def assign_to_lab
      self.lab = self.collaborators.first if self.collaborators
    end

    def strip_zeroes
      self.tag_list.remove("0")
    end
end
