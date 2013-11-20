class Lab < ActiveRecord::Base

  include Authority::Abilities
  resourcify
  self.authorizer_name = 'LabAuthorizer'

  include PgSearch
  pg_search_scope :search_by_name, :against => [:name, :description]

  include Avatarable

  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged

  include Workflow
  workflow do
    state :unverified do
      event :approve, transitions_to: :approved
      # event :reject, transitions_to: :rejected
    end
    state :approved
    state :rejected
  end

  has_many :role_applications
  has_many :links, as: :linkable
  has_many :employees
  has_many :discussions, as: :discussable
  has_many :facilities
  has_many :tools, through: :facilities, source: :thing, source_type: 'Tool'
  belongs_to :creator, class_name: 'User'

  validates :slug, format: {:with => /\A[a-zA-Z0-9]+\z/ }, allow_nil: true, allow_blank: true, length: { minimum: 3 }
  validates_format_of :email, :with => /\A(.+)@(.+)\z/, allow_blank: true
  validates :name, :description, :address_1, :country_code, :slug, presence: true
  validates_presence_of :creator, on: :create
  validates_uniqueness_of :name, :slug, case_sensitive: false
  validate :excluded_login
  def excluded_login
    if !slug.blank? and $bannedWords.include?(slug.downcase)
      errors.add(:slug, "is reserved")
    end
  end

  accepts_nested_attributes_for :links, reject_if: lambda{ |l| l[:url].blank? }, allow_destroy: true

  scope :search_for, ->(q) { search_by_name(q) if q.present?}
  scope :in_country_code, ->(cc) { where(country_code: cc) if cc.present?}

  after_create :notify_everyone
  before_save :downcase_email
  after_save :save_roles

  attr_accessor :geocomplete
  geocoded_by :formatted_address

  def nearby_labs same_country = true, max_distance = 1000
    if nearbys(max_distance)
      labs = nearbys(max_distance).with_approved_state.limit(5)
      if same_country
        labs = labs.where(country_code: country_code)
      end
      return labs
    end
  end

  def formatted_address
    [address_1, address_2, city, county, postal_code, country]
    .reject(&:blank?).join(", ")
  end

  def short_address
    "#{city}, #{country}"
  end

  def default_avatar
    'http://i.imgur.com/iymHWkm.png'
    # 'default-lab-avatar.png'
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

  def downcase_email
    self.email = email.downcase if email.present?
  end

end
