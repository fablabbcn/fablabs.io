class User < ActiveRecord::Base
  rolify

  include Authority::UserAbilities

  validates :first_name, :last_name, :email, :password, presence: true
  has_many :created_labs, class_name: 'Lab', foreign_key: 'creator_id'
  validates_uniqueness_of :email, case_sensitive: false
  has_secure_password

  include Workflow
  workflow do
    state :unverified do
      event :verify, transitions_to: :verified
    end
    state :verified
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
