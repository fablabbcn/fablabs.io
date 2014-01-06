class CouponSerializer < ActiveModel::Serializer
  attributes :id, :description, :value, :redeemed_at
end
