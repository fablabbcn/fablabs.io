class Thing < ActiveRecord::Base
  include Authority::Abilities
  self.authorizer_name = 'ThingAuthorizer'

  after_create :update_photo_src

  dragonfly_accessor :photo

  has_ancestry
  belongs_to :brand
  validates_presence_of :name
  has_many :discussions, as: :discussable
  has_many :facilities
  accepts_nested_attributes_for :facilities
  has_many :labs, through: :facilities
  has_many :links, as: :linkable

  has_many :documents, as: :documentable, dependent: :destroy
  accepts_nested_attributes_for :documents

  accepts_nested_attributes_for :links, reject_if: lambda{ |l| l[:url].blank? }, allow_destroy: true

  acts_as_taggable

  def to_param
    "#{id}-#{name}".parameterize
  end

  def to_s
    name
  end

  def self.arrange_as_array(options={}, hash=nil)
    hash ||= arrange(options)

    arr = []
    hash.each do |node, children|
      arr << node
      arr += arrange_as_array(options, children) unless children.nil?
    end
    arr
  end

  def self.last_updated_at
    self.select(:updated_at).order('updated_at DESC').first
  end

  private

    def update_photo_src
      if self.photo_src.present? and self.photo_src.empty?
        self.photo_src = self.documents.first.image.url(:large) if documents.first
      end
    end

end
