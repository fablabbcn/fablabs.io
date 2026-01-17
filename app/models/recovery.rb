class RecoveryUserValidator < ActiveModel::Validator
  def validate(record)
    unless User.where('email = :eu or email_fallback = :eu or username = :eu', eu: record.email_or_username).exists?
      record.errors.add(:email_or_username, message: "Sorry, we can't find a user with that username or email address")
    end
  end
end

class Recovery < ActiveRecord::Base

  include ActiveModel::Validations
  validates_with RecoveryUserValidator, on: :create

  include Tokenable

  attr_accessor :email_or_username
  belongs_to :user

  accepts_nested_attributes_for :user

  before_create :associate_user
  before_create { generate_token(:key) }

  def to_param
    key
  end

private

  def associate_user
    self.user = User.where('email = :eu or email_fallback = :eu or username = :eu', eu: email_or_username).first
  end

end
