class Organization < ActiveRecord::Base

  KINDS = ['global', 'continent', 'country', 'state', 'region', 'province', 'city']

  WORKFLOW_STATES = [
    STATE_PENDING  = 'pending',
    STATE_APPROVED = 'approved'
  ]

  has_many :labs, through: :lab_organizations
  has_many :lab_organizations

  belongs_to :creator, class_name: 'User'

  validates :name, presence: true
  validates :slug, presence: true, length: { minimum: 3 }, uniqueness: { case_sensitive: false}
  validates :kind, inclusion: {in: KINDS}
  validates :workflow_state, inclusion: {in: WORKFLOW_STATES}
  validates :address_1, presence: true, on: :create

  validates_format_of :email, :with => /\A(.+)@(.+)\z/, allow_blank: true

  before_save :truncate_blurb
  before_validation :set_initial_workflow_state, on: :create

  scope :approved, -> {where(workflow_state: STATE_APPROVED)}

  after_save :discourse_sync_if_needed, if: Figaro.env.discourse_enabled

  attr_accessor :geocomplete

  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged
  def slug_candidates
    [:name]
  end

  def should_generate_new_friendly_id?
    new_record?
  end

  def avatar
    if avatar_src.present?
      avatar_src
    else
      'https://i.imgur.com/iymHWkm.png'
    end
  end

  def async_discourse_sync
    DiscourseOrganizationWorker.perform_async(self.id)
  end

  def discourse_sync
    DiscourseService::Organization.new(self).sync
  end

  def formatted_address
    [address_1, address_2, city, county, postal_code, country].reject(&:blank?).join(", ")
  end

  def short_address include_country = true
    [city, county, (country if include_country)].reject(&:blank?).join(", ")
  end

  def country
    ISO3166::Country[country_code]
  end

  geocoded_by :formatted_address
  reverse_geocoded_by :latitude, :longitude do |org,results|
    if geo = results.first
      org.city ||= geo.city
      org.county ||= geo.state
      org.postal_code ||= geo.postal_code
      org.country_code ||= geo.country_code
      org.reverse_geocoded_address = Marshal.dump([geo.address,geo])
      org.save
    end
  end

  private

  def discourse_sync_if_needed
    if (changes.keys & ["name", "description"]).present?
      async_discourse_sync
    end
  end

  def truncate_blurb
    self.blurb = blurb[0...250].gsub(/\s+/, ' ').gsub(/\n/," ").strip if blurb_changed?
  end

  def set_initial_workflow_state
    self.workflow_state ||= STATE_APPROVED
  end
end
