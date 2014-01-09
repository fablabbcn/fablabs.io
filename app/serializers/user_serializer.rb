class UserSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :email, :avatar, :fab10_coupon_code, :fab10_claimed_at, :fab10_cost
  has_many :employees
end
