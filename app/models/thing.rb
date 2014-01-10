class Thing < ActiveRecord::Base

  include Authority::Abilities
  self.authorizer_name = 'ThingAuthorizer'

  has_ancestry
  belongs_to :brand
  validates_presence_of :name
  has_many :discussions, as: :discussable
  has_many :facilities
  has_many :labs, through: :facilities
  has_many :links, as: :linkable

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

end
