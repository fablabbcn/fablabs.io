class UserJsonapiSerializer < ActiveModel::Serializer
  attributes :data
  def data
    {
      id: object.id,
      type: "me",
      attributes: {
        username: object.username,
        first_name: object.first_name,
        last_name: object.last_name,
        email: object.email,
        avatar: object.avatar,
        fab10_coupon_code: object.fab10_coupon_code,
        fab10_claimed_at: object.fab10_claimed_at,
        fab10_cost: object.fab10_cost
      }
    }
  end
end
