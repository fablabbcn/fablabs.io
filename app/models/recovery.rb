class RecoveryUserValidator < ActiveModel::Validator
  def validate(record)
    unless User.where(email: record.email).exists?
      record.errors[:email] << 'Sorry, we have no user with that email address'
    end
  end
end

class Recovery < ActiveRecord::Base

  include ActiveModel::Validations
  validates_with RecoveryUserValidator, on: :create

  attr_accessor :email
  belongs_to :user

  accepts_nested_attributes_for :user

  before_create :associate_user
  before_create :generate_key
  after_create :email_user

  def to_param
    key
  end

private

  def generate_key
    begin
      self.key = SecureRandom.urlsafe_base64
    end while Recovery.exists?(key: self.key)
  end

  def associate_user
    self.user = User.where(email: self.email).first
  end

  def email_user
    UserMailer.account_recovery_instructions(user).deliver
  end

end