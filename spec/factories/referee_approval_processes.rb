# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryBot.define do
  factory :referee_approval_process do
    association :referee_lab, factory: :lab
    association :referred_lab, factory: :lab
    approved { nil }

    trait :unapproved do
      approved { false }
    end

    trait :approved do
      approved { true }
    end
  end
end