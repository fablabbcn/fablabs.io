class Lab < ActiveRecord::Base
  include RocketPants::Cacheable
  include Authority::Abilities
  include Workflow
  include ApproveWorkflow

  self.authorizer_name = 'LabAuthorizer'
  resourcify
  has_ancestry

  include PgSearch
  pg_search_scope :search_by_name, :against => [:name, :description, :reverse_geocoded_address]

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |lab|
        csv << lab.attributes.values_at(*column_names)
      end
    end
  end

  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged
  def slug_candidates
    [:name]
  end

  has_many :academics
  has_many :admin_applications
  has_many :events
  has_many :discussions, as: :discussable
  has_many :employees
  has_many :links, as: :linkable
  has_many :referred_labs, foreign_key: 'referee_id', class_name: 'Lab'
  has_many :role_applications
  has_many :facilities
  has_many :machines, through: :facilities, source: :thing
  has_many :projects

  belongs_to :creator, class_name: 'User'
  belongs_to :referee, class_name: 'Lab'

  validates_presence_of :name, :country_code, :slug#, :creator
  validates_presence_of :address_1, :kind, on: :create

  validates :slug, format: {:with => /\A[a-zA-Z0-9]+\z/ }, allow_nil: true, allow_blank: true, length: { minimum: 3 }
  validates_format_of :email, :with => /\A(.+)@(.+)\z/, allow_blank: true
  validates_uniqueness_of :name, :slug, case_sensitive: false
  validate :excluded_slug

  def excluded_slug
    if !slug.blank? and Fablabs::Application.config.banned_words.include?(slug.downcase)
      errors.add(:slug, "is reserved")
    end
  end

  Kinds = %w(planned_fab_lab mini_fab_lab fab_lab)
  Capabilities = %w(three_d_printing cnc_milling circuit_production laser precision_milling vinyl_cutting)
  bitmask :capabilities, as: Capabilities

  unless Rails.env.test?
    validates :referee, presence: true, on: :create
  end
  # validates :employees, presence: true, on: :create

  accepts_nested_attributes_for :links, reject_if: lambda{ |l| l[:url].blank? }, allow_destroy: true
  accepts_nested_attributes_for :employees

  scope :search_for, ->(q) { search_by_name(q) if q.present?}
  scope :in_country_code, ->(cc) { where(country_code: cc) if cc.present?}

  before_save :downcase_email
  before_save :truncate_blurb
  before_save :get_time_zone unless Rails.env.test?
  after_save :save_roles

  attr_accessor :geocomplete

  def needs_admin?
    !direct_admins.any?
  end

  geocoded_by :formatted_address
  reverse_geocoded_by :latitude, :longitude do |lab,results|
    if geo = results.first
      lab.city ||= geo.city
      lab.county ||= geo.state
      lab.postal_code ||= geo.postal_code
      lab.country_code ||= geo.country_code
      lab.reverse_geocoded_address = Marshal.dump([geo.address,geo])
      lab.save
    end
  end

  def nearby_labs same_country = true, max_distance = 1000
    if nearbys(max_distance)
      labs = nearbys(max_distance, units: :km).limit(5).with_approved_state
      if same_country
        labs = labs.where(country_code: country_code)
      end
      return labs
    end
  end

  def kind_name
    Kinds[ (kind >= 0 && kind <= 2) ? kind : 2 ]
  end

  def active?
    kind > 0
  end

  def formatted_address
    [address_1, address_2, city, county, postal_code, country].reject(&:blank?).join(", ")
    #
  end

  def short_address include_country = true
    [city, county, (country if include_country)].reject(&:blank?).join(", ")
  end

  def avatar
    if avatar_src.present?
      avatar_src
    else
      'https://i.imgur.com/iymHWkm.png'
    end
  end

  def approved_referees
    referees = [
      "thewellingtonmakerspace",
      "fablabtaipei",
      "waagsociety",
      "fablablima",
      "fablabuniversidadedesaopaulo",
      "fablabsandiego",
      "as220labs",
      "fablabbcn",
      "fablabcascina",
      "vigyanashram",
      "fablabkamakura"
    ]

    Lab.where(slug: referees).order('name ASC')

  end

  def referee_approve
    employees.update_all(workflow_state: :referee_approved)
  end

  def add_more_info
    employees.update_all(workflow_state: :more_info_added)
  end

  def need_more_info
    employees.update_all(workflow_state: :more_info_needed)
  end

  def approve
    employees.update_all(workflow_state: :approved)
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
    labs.map{ |v| c[v[:country_code]] += 1 }
    countries = []
    c.each do |country_code, count|
      if Country[country_code]
        countries.push([Country[country_code].name, country_code, count])
      end
    end
    return countries.sort_alphabetical_by(&:first)
  end

  def direct_admins
    User.with_role(:admin, self)# - User.with_role(:superadmin)
  end

  def admins
    a = direct_admins
    a = User.with_role(:superadmin) if a.empty?
    return a
  end

  def admin_ids
    @admin_ids ||= (User.with_role(:admin, self) - User.with_role(:superadmin)).map(&:id)
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

  def self.last_updated_at
    self.select(:updated_at).order('updated_at DESC').first
  end

private

  def get_time_zone
    if latitude_changed? or longitude_changed?
      begin
        self.time_zone = (Timezone::Zone.new :latlon => [latitude, longitude]).zone
      rescue Timezone::Error::NilZone
      end
    end
  end

  def downcase_email
    self.email = email.downcase if email.present?
  end

  def truncate_blurb
    self.blurb = blurb[0...250].gsub(/\s+/, ' ').gsub(/\n/," ").strip if blurb_changed?
  end

end
