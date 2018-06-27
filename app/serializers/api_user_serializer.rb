class Api::V2::UserSerializer   < ApiV2Serializer
    include FastJsonapi::ObjectSerializer
    attributes :id, :username, :first_name, :last_name, :email, :avatar_url, :fab10_coupon_code, :fab10_claimed_at, :fab10_cost
    has_many :employees
end
  