class User < ActiveRecord::Base
  rolify

  include Authority::UserAbilities

  validates :first_name, :last_name, :email, :password, presence: true
  has_many :created_labs, class_name: 'Lab', foreign_key: 'creator_id'
  validates_uniqueness_of :email
  has_secure_password

  include Workflow
  workflow do
    state :unverified do
      event :verify, transitions_to: :verified
    end
    state :verified
  end

  def to_s
    email
  end

  def admin?
    has_role? :admin
  end

end
