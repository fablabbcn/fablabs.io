# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :referee_approval_process do
    referee_lab_id 2
    refereed_lab_id 1
  end
end
