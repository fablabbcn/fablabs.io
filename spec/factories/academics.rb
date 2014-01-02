# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :academic do
    user nil
    lab nil
    started_in 1
    type ""
    approver nil
  end
end
