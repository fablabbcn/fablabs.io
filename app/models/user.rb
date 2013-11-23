class User < ActiveRecord::Base

  include Tokenable
  include Avatarable
  include Authority::UserAbilities
  include Workflow

  rolify :after_add => :after_add_method, :after_remove => :after_remove_method

  def after_add_method(role)
    UserMailer.role_added(role, self).deliver
  end

  def after_remove_method(role)
    UserMailer.role_removed(role, self).deliver
  end

  has_secure_password

  has_many :created_labs, class_name: 'Lab', foreign_key: 'creator_id'
  has_many :comments, foreign_key: 'author_id'
  has_many :discussions, foreign_key: 'creator_id'
  has_many :recoveries
  has_many :role_applications
  has_many :employees

  validates_format_of :email, :with => /\A(.+)@(.+)\z/
  validates :first_name, :last_name, :email, presence: true
  validates_uniqueness_of :email, case_sensitive: false
  validates :password, presence: true, length: { minimum: 6 }, if: lambda{ !password.nil? }, on: :update

  before_create { generate_token(:email_validation_hash) }
  before_create :downcase_email
  before_update :check_if_email_changed
  after_create :send_welcome_email

  workflow do
    state :unverified do
      event :verify, transitions_to: :verified
      event :unverify, transitions_to: :unverified
    end
    state :verified do
      event :unverify, transitions_to: :unverified
    end
  end

  def default_avatar
    'default-user-avatar.png'
  end

  def employed_by? lab
    Employee.where(lab: lab, user: self).exists?
  end

  def locale
    my_locale || I18n.default_locale
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def to_s
    full_name
  end

  def admin?
    has_role? :admin
  end

  def recovery_key
    recoveries.last.key
  end

  def unverify
    generate_token(:email_validation_hash)
    send_verification_email
  end

  def send_verification_email
    UserMailer.verification(self).deliver# if unverified?
  end

  def email_string
    "#{self} <#{self.email}>"
  end

  def self.admin_emails
    # User.with_role(:admin).exists? ? User.with_role(:admin).map(&:email) :
    ['john@bitsushi.com']
  end

private

  def downcase_email
    self.email.downcase!
  end

  def send_welcome_email
    UserMailer.welcome(self).deliver
  end

  def check_if_email_changed
    unverify! if email_changed?
  end

end
