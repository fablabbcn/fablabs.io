# frozen_string_literal: true

class ApiUserSerializer < ApiV2Serializer
  set_type :user
  attributes :id, :username, :first_name, :last_name, :email, :avatar_url
  has_many :employees, record_type: :employee
  attribute :email_verified, &:verified?
end
