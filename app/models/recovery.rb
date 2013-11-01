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

  include Tokenable

  attr_accessor :email
  belongs_to :user

  accepts_nested_attributes_for :user

  before_create :associate_user
  before_create { generate_token(:key) }
  after_create :email_user

  def to_param
    key
  end

  def self.find_by_key key
    select('recoveries.user_id, recoveries.key').
    where(key: key).
    from(Recovery.order('id DESC').group(:user_id, :key, :id).limit(1).as('recoveries')).
    group([:user_id,:id,:key]).last
  end

private

  def associate_user
    self.user = User.where(email: self.email).first
  end

  def email_user
    UserMailer.account_recovery_instructions(user).deliver
  end

end