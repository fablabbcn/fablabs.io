class ApiUserSerializer   < ApiV2Serializer
    attributes :id, :username, :first_name, :last_name, :email, :avatar_url
    has_many :employees
end
  