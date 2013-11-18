class User < ActiveRecord::Base
  include Tokenable

  rolify
  has_secure_password
  include Authority::UserAbilities
  validates_format_of :email, :with => /\A(.+)@(.+)\z/
  validates :first_name, :last_name, :email, presence: true
  has_many :created_labs, class_name: 'Lab', foreign_key: 'creator_id'
  has_many :comments, foreign_key: 'author_id'
  has_many :discussions, foreign_key: 'creator_id'
  has_many :recoveries
  has_many :role_applications
  has_many :employees
  before_create { generate_token(:email_validation_hash) }
  validates_uniqueness_of :email, case_sensitive: false
  validates :password, presence: true, length: { minimum: 6 }, if: lambda{ !password.nil? }, on: :update

  include Workflow
  workflow do
    state :unverified do
      event :verify, transitions_to: :verified
    end
    state :verified
  end

  include Avatarable
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

  def send_verification_email
    UserMailer.verification(self).deliver
  end

  def email_string
    "#{self} <#{self.email}>"
  end

  def self.admin_emails
    User.with_role(:admin).exists? ? User.with_role(:admin).map(&:email) : ['john@bitsushi.com']
  end

  before_create :downcase_email
  after_create :send_welcome_email

private

  def downcase_email
    self.email.downcase!
  end

  def send_welcome_email
    UserMailer.welcome(self).deliver
  end

end
