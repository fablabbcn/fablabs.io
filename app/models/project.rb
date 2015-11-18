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

  has_many :documents, as: :documentable, dependent: :destroy
  accepts_nested_attributes_for :documents

  has_many :steps, dependent: :destroy
  accepts_nested_attributes_for :steps, allow_destroy: true

  has_many :favourites
  has_many :users, :through => :favourites

  has_many :grades
  has_many :users, :through => :grades

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

  def grade_average
    num = self.grades.count
    if num > 0
      total = self.total_grades
      return total / num
    else
      return 0
    end
  end

  def project_cover
    begin
      if self.documents.empty?
        return 'none'
      elsif self.cover.present?
        return self.documents.find(self.cover).image.url(:medium)
      elsif self.documents.first
        return self.documents.first.image.url(:medium)
      else
        return 'none'
      end
    rescue ActiveRecord::RecordNotFound
      return 'none'
    end
  end

  protected
    def total_grades
      total = 0
      self.grades.each do |grade|
        total += grade.stars
      end
      return total
    end

  private
    def assign_to_lab
      self.lab = self.collaborators.first if self.collaborators
    end

    def strip_zeroes
      self.tag_list.remove("0")
    end
end
