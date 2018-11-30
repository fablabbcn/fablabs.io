# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryBot.define do
  factory :referee_approval_process do
    referee_lab_id { 2 }
    referred_lab_id { 1 }
  end
end
