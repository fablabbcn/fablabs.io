class Step < ActiveRecord::Base
  belongs_to :project
  has_many :links, as: :linkable
  accepts_nested_attributes_for :links, allow_destroy: true

  before_create :assign_position

  validates :title, presence: true, allow_blank: false
  validates :description, presence: true, allow_blank: false

  private
    def assign_position
      p = self.project.steps.count
      self.position = p+1
    end
end
