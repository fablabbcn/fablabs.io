class EmployeeSerializer < ActiveModel::Serializer
  attributes :id, :job_title, :lab_id
  # has_one :user
  # has_one :lab
end
