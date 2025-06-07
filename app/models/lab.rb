class Lab < ApplicationRecord
  include RocketPants::Cacheable
  include Authority::Abilities
  include Workflow
  include WorkflowActiverecord
  include ApproveWorkflow
  include LabApproveMethods

  extend DragonflyValidations
  dragonfly_accessor :avatar do
    default 'public/default-lab-avatar.png'
  end
  dragonfly_validations :avatar

  dragonfly_accessor :header
  dragonfly_validations :header

  self.authorizer_name = 'LabAuthorizer'
  resourcify
  has_ancestry

  include PgSearch::Model
  pg_search_scope :search_by_name, :against => [:name, :description, :reverse_geocoded_address]

  extend FriendlyId
  friendly_id :slug_candidates, use: [:slugged, :finders]
  def slug_candidates
    [:name]
  end

  KINDS = [ 'mini_fab_lab', 'fab_lab', 'mobile']
  enum kind: { mini_fab_lab: 0, fab_lab: 1, mobile: 3 }

  ACTIVITY_STATUS = [
    'planned',
    'active',
    'corona',
    'closed'
  ].freeze

  has_many :academics
  has_many :admin_applications
  has_many :events
  has_many :discussions, as: :discussable
  has_many :employees, dependent: :destroy
  has_many :links, as: :linkable, dependent: :destroy
  accepts_nested_attributes_for :links, reject_if: lambda{ |l| l[:url].blank? }, allow_destroy: true

  has_many :role_applications
  has_many :facilities
  accepts_nested_attributes_for :facilities
  has_many :machines, through: :facilities, source: :thing
  has_many :projects

  has_many :documents, as: :documentable, dependent: :destroy
  accepts_nested_attributes_for :documents

  belongs_to :creator, class_name: 'User'
  belongs_to :referee, class_name: 'Lab'
  has_many :organizations, through: :lab_organizations
  has_many :lab_organizations

  has_many :lab_taggings
  has_many :lab_tags, through: :lab_taggings

  has_many :referee_approval_processes, foreign_key: 'referred_lab_id', dependent: :destroy
  accepts_nested_attributes_for :referee_approval_processes
  has_many :referees, through: :referee_approval_processes, source: :referee_lab
  has_many :referred_labs, through: :referee_approval_processes, source: :referred_lab

  has_many :approval_workflow_logs

  # TODO: Reenable if needed and fix tests.
  # Also decide which attribute changes should trigger a new lat/lng
  #after_validation :geocode, if: :my_address_changed?

  validates_presence_of :name, :country_code, :slug, :email#, :creator
  validates_presence_of :address_1, on: :create

  validates_inclusion_of :kind, in: kinds.keys, on: :create

  validates_acceptance_of :network, :programs, :tools, :access, :chart, :accept => true, message: 'You must agree to our terms and conditions.', on: :create

  validates :slug, format: {:with => /\A[a-zA-Z0-9]+\z/ }, allow_nil: true, allow_blank: true, length: { minimum: 3 }

  validates_presence_of :blurb
  validates_presence_of :description
  validates_presence_of :phone

  validates_format_of :email, :with => /\A(.+)@(.+)\z/
  validates_uniqueness_of :name, :slug, case_sensitive: false

  Capabilities = %w(three_d_printing cnc_milling circuit_production laser precision_milling vinyl_cutting)
  bitmask :capabilities, as: Capabilities

  unless Rails.env.test?
    validates :referee_approval_processes, presence: true,
      length: { is:       3,
                message:  "length is incorrect. In order to be approved you must select %{count} referees." },
      unless: :is_approved?
  end
  # validates :employees, presence: true, on: :create

  accepts_nested_attributes_for :employees

  scope :search_for, ->(q) { search_by_name(q) if q.present? }
  scope :in_country_code, ->(cc) { where(country_code: cc) if cc.present?}
  scope :approved_referees, -> { where(is_referee: true).order('name ASC') }
  scope :approved, -> { where(workflow_state: :approved) }
  scope :pending, -> { where(workflow_state: :pending) }
  scope :unverified, -> { where(workflow_state: :unverified) }

  before_save :downcase_email
  before_save :truncate_blurb
  before_save :get_time_zone unless Rails.env.test?
  after_save :save_roles
  after_save :discourse_sync_if_needed, if: -> { ENV['DISCOURSE_ENABLED'] }

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

  def my_address_changed?
    address_1_changed? || address_2_changed?
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

  def active?
    self.class::kinds[kind] > 0
  end

  def formatted_address
    [address_1, address_2, city, county, postal_code, country].reject(&:blank?).join(", ")
  end

  def short_address include_country = true
    [city, county, (country&.common_name if include_country)].reject(&:blank?).join(", ")
  end

  def to_s
    name
  end

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |lab|
        csv << lab.attributes.values_at(*column_names)
      end
    end
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

  def self.labs_in_continent(continent)
    countries_in_continent = ISO3166::Country.find_all_countries_by_continent(continent).map(&:alpha2)
    Lab.where(country_code: countries_in_continent)
  end

  def self.last_updated_at
    self.select(:updated_at).order('updated_at DESC').first
  end

  def is_approved?
    return true if workflow_state == "approved"
  end

  def async_discourse_sync
    DiscourseLabWorker.perform_async(self.id)
  end

  def discourse_sync
    DiscourseService::Lab.new(self).sync
  end

  def avatar_url
    if avatar_uid.present?
      avatar.thumb('150x150#').url
    else
      default_url = "https://www.fablabs.io/default-lab-avatar.png"
      if email.present?
        gravatar_id = Digest::MD5.hexdigest(email.downcase)
        "https://gravatar.com/avatar/#{gravatar_id}.png?s=150&d=#{CGI.escape(default_url)}"
      else
        default_url
      end
    end
  end

  private

  def discourse_sync_if_needed
    if (changes.keys & ["name", "description"]).present?
      async_discourse_sync
    end
  end

  def get_time_zone
    if latitude_changed? or longitude_changed?
      begin
        self.time_zone = (Timezone::Zone.new :latlon => [latitude, longitude]).zone
      rescue NoMethodError
      end
    end
  end

  def downcase_email
    self.email = email.downcase if email.present?
  end

  def truncate_blurb
    self.blurb = blurb[0...250].gsub(/\s+/, ' ').gsub(/\n/," ").strip if blurb_changed?
  end

  def self.ransackable_attributes(auth_object = nil)
    if auth_object == :admin or auth_object == :superadmin
      ['id', 'name', 'city', 'country_code', 'activity_status', 'workflow_state', 'is_referee', 'kind']
    else
      ['id', 'name', 'city', 'country_code', 'activity_status'] 
    end
  end

  def self.ransackable_associations(auth_object = nil)
    %w[lab_tags creator]
  end
end
