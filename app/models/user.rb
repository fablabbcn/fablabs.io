class User < ActiveRecord::Base

  validates :first_name, :last_name, :email, :password, presence: true
  has_many :created_labs, class_name: 'Lab', foreign_key: 'creator_id'
  has_secure_password

  include Workflow
  workflow do
    state :unverified do
      event :verify, transitions_to: :verified
    end
    state :verified
  end

end
