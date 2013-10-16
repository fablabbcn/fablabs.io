# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :lab do
    workflow_state "MyString"
    name "MyString"
    slug "MyString"
    description "MyText"
  end
end
