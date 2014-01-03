class Coupon < ActiveRecord::Base
  before_create :generate_token
  belongs_to :user
  validates_presence_of :user

private

  def generate_token
    self.code = SecureRandom.urlsafe_base64[0..10].gsub(/[^0-9a-zA-Z]/i, '')
  end
end
