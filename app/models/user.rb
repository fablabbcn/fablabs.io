class User < ActiveRecord::Base
  rolify
  has_secure_password
  include Authority::UserAbilities

  validates :first_name, :last_name, :email, presence: true
  has_many :created_labs, class_name: 'Lab', foreign_key: 'creator_id'
  has_many :recoveries
  validates_uniqueness_of :email, case_sensitive: false
  validates :password, presence: true, length: { minimum: 6 }, on: :update, if: lambda{ new_record? || !password.nil? }

  include Workflow
  workflow do
    state :unverified do
      event :verify, transitions_to: :verified
    end
    state :verified
  end

  def avatar
    avatar_src || ActionController::Base.helpers.asset_path('/assets/default-user-avatar.png')
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
