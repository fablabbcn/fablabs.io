class EmployeeSerializer < ActiveModel::Serializer
  attributes :id, :ordinal, :job_title, :description, :started_on, :finished_on
  has_one :user
  has_one :lab
end
