class User < ActiveRecord::Base

  # TODO: friendly_id

  has_many :access_grants, class_name: "Doorkeeper::AccessGrant",
                           foreign_key: :resource_owner_id,
                           dependent: :delete_all # or :destroy if you need callbacks

  has_many :access_tokens, class_name: "Doorkeeper::AccessToken",
                           foreign_key: :resource_owner_id,
                           dependent: :delete_all # or :destroy if you need callbacks

  include Tokenable
  include Authority::UserAbilities
  include Authority::Abilities
  self.authorizer_name = 'UserAuthorizer'

  before_create :generate_fab10_coupon_code

  extend DragonflyValidations
  dragonfly_accessor :avatar do
    default 'public/default-user-avatar.png'
  end
  dragonfly_validations(:avatar)

  include Workflow
  include VerifyWorkflow

  rolify
  has_secure_password

  has_many :created_organizations, class_name: 'Organization', foreign_key: 'creator_id'
  has_many :created_events, class_name: 'Event', foreign_key: 'creator_id'
  has_many :created_labs, class_name: 'Lab', foreign_key: 'creator_id'
  has_many :created_projects, class_name: 'Project', foreign_key: 'owner_id'
  has_many :comments, foreign_key: 'author_id'
  has_many :discussions, foreign_key: 'creator_id'
  has_many :recoveries
  has_many :role_applications
  has_many :employees
  has_one  :coupon

  has_many :academics

  has_many :links, as: :linkable
  accepts_nested_attributes_for :links, reject_if: lambda{ |l| l[:url].blank? }, allow_destroy: true

  has_many :created_activities, foreign_key: 'creator_id', class_name: 'Activity'
  has_many :activities, foreign_key: 'actor_id'

  has_many :contributions, foreign_key: 'contributor_id'
  has_many :projects, through: :contributions

  has_many :favourites
  has_many :projects, :through => :favourites

  has_many :grades
  has_many :projects, :through => :grades

  validates_acceptance_of :agree_policy_terms, :accept => true, on: :create

  validates_format_of :email, :with => /\A(.+)@(.+)\z/
  validates :username, format: { :with => /\A[a-zA-Z0-9]+(\.)?[a-zA-Z0-9]+\z/ }, length: { minimum: 4, maximum: 50 }
  
  validates :first_name, :last_name, :email, :username, presence: true
  validates_uniqueness_of :email, :username, case_sensitive: false
  validates :password, presence: true, length: { minimum: 6 }, if: lambda{ !password.nil? }, on: :update
  validate :excluded_login
  def excluded_login
    if !username.blank? and Fablabs::Application.config.banned_words.include?(username.downcase)
      errors.add(:username, "is reserved")
    end
  end

  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged
  def slug_candidates
    [:username]
  end

  before_create { generate_token(:email_validation_hash) }
  before_create :downcase_email

  after_save :discourse_sync_if_needed, if: Figaro.env.discourse_enabled

  def avatar_url
    if avatar_uid.present?
      avatar.thumb('150x150#').url
    else
      default_url = "https://www.fablabs.io/default-user-avatar.png"
      gravatar_id = Digest::MD5.hexdigest(email.downcase)
      "https://gravatar.com/avatar/#{gravatar_id}.png?s=150&d=#{CGI.escape(default_url)}"
    end
  end

  def studied_at? lab
    academics.where(lab: lab).exists?
  end

  def employed_by? lab
    Employee.with_approved_state.where(lab: lab, user: self).exists?
  end

  def applied_to? lab
    Employee.where(lab: lab, user: self).exists?
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def to_s
    full_name
  end

  def default_locale
    locale || I18n.default_locale
  end

  def superadmin?
    has_role? :superadmin
  end

  def admin_labs
    self.roles.where(name: "admin", resource_type: "Lab")
  end

  def is_unique_referee?
    return true if not Lab.where("referee_id IN (?)",  self.admin_labs.map{ |u| u.resource_id }).empty?
  end

  def is_referee?
    return true if not RefereeApprovalProcess.where("referee_lab_id IN (?)", self.admin_labs.map{ |u| u.resource_id }).empty?
  end

  def is_creator? lab
    return true if lab.creator_id == self.id
  end

  def favourited? project_id
    return true if self.favourites.where(project_id: project_id).first
  end

  def graded? project_id
    return true if self.grades.where(project_id: project_id).first
  end

  def favourite project_id
    return self.favourites.where(project_id: project_id).first
  end

  def grade project_id
    return self.grades.where(project_id: project_id).first
  end

  def unique_referee_labs
    Lab.where("referee_id IN (?) AND workflow_state IN (?)", self.admin_labs.map{ |u| u.resource_id }, ['unverified', 'more_info_needed', 'more_info_added'])
  end

  def pending_referee_labs
    labs = RefereeApprovalProcess.where(referee_lab_id: admin_labs.map(&:resource_id)).map(&:referred_lab).uniq
    labs.select{ |lab| lab if ['unverified', 'need_more_info', 'more_info_added'].include?(lab.workflow_state) }
  end

  def referee_labs
    RefereeApprovalProcess.where(referee_lab_id: admin_labs.map(&:resource_id)).map(&:referred_lab).uniq
  end

  def referees_count
    unique_referee_labs.count + pending_referee_labs.count
  end

  def recovery_key
    recoveries.last.key if recoveries.any?
  end

  def unverify
    generate_token(:email_validation_hash)
  end

  def email_string
    "#{self} <#{self.email}>"
  end

  def self.admin_emails
    User.with_role(:superadmin).map(&:email)
  end

  # def coupon_code
  #   SecureRandom.urlsafe_base64[0..10].gsub(/[^0-9a-zA-Z]/i, '')
  # end

  def generate_fab10_coupon_code
    if self.fab10_coupon_code.blank?
      self.fab10_coupon_code = loop do
        random_token = SecureRandom.urlsafe_base64[0..10].gsub(/[^0-9a-zA-Z]/i, '')
        break random_token unless User.exists?(fab10_coupon_code: random_token)
      end
    end

    if employees.with_approved_state.any?
      self.fab10_cost = 35000
    end
  end

  def role_names
    roles.map(&:name).uniq.join(', ')
  end

  def async_discourse_sync
    DiscourseUserSyncWorker.perform_async(self.id)
  end

  private

  def discourse_sync_if_needed
    if (changes.keys & ["first_name", "last_name", "username", "email"]).present?
      async_discourse_sync
    end
  end

  def downcase_email
    self.email.downcase!
  end

end
