class Lab < ActiveRecord::Base
  include PgSearch
  pg_search_scope :search_by_name, :against => [:name, :description]
  has_many :role_applications
  scope :search, ->(q) { search_by_name(q) if q.present?}
  scope :in_country_code, ->(cc) { where(country_code: cc) if cc.present?}
  resourcify
  include Authority::Abilities
  self.authorizer_name = 'LabAuthorizer'

  belongs_to :creator, class_name: 'User'
  validates :name, :description, :address_1, :country_code, presence: true
  validates_presence_of :creator, on: :create
  validates_uniqueness_of :name, case_sensitive: false

  after_create :notify_everyone

  attr_accessor :geocomplete
  geocoded_by :formatted_address

  def formatted_address
    [address_1, address_2, address_3, city, postal_code, country]
    .reject(&:blank?).join(", ")
  end

  def short_address
    "#{city}, #{country}"
  end

  include Avatarable
  def default_avatar
    'default-lab-avatar.png'
  end

  def approve
    UserMailer.lab_approved(self).deliver
    creator.add_role :admin, self
  end

  def to_s
    name
  end

  def country
    Country[country_code]
  end

  def self.country_list_for labs
    c = Hash.new(0)
    # labs.pluck(:country_code).map{ |v| c[v] += 1 }
    labs.map{ |v| c[v[:country_code]] += 1 }
    countries = []
    c.each do |country_code, count|
      countries.push([Country[country_code].name, country_code, count])
    end
    return countries.sort_by!{|k|k.first}
  end

  def admins
    User.with_role(:admin, self) - User.with_role(:admin)
  end

  def admin_ids
    @admin_ids ||= (User.with_role(:admin, self) - User.with_role(:admin)).map(&:id)
  end

  def admin_ids=(user_ids)
    @admin_ids = user_ids
  end

  after_save :save_roles
  def save_roles
    if @admin_ids
      @admin_ids.reject!(&:blank?)
      users = User.with_role(:admin, self).where("users.id not IN (?)", @admin_ids)
      users.each do |user|
        user.revoke :admin, self
      end
      users = User.find(@admin_ids)
      users.each do |user|
        user.add_role :admin, self
      end
    end
  end

  include Workflow
  workflow do
    state :unverified do
      event :approve, transitions_to: :approved
      # event :reject, transitions_to: :rejected
    end
    state :approved
    state :rejected
  end

  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged

  def slug_candidates
    [
      :name
    ]
  end

private

  def notify_everyone
    UserMailer.lab_submitted(self).deliver
    AdminMailer.lab_submitted(self).deliver
  end

end
