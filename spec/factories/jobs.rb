# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryBot.define do
  factory :job do
    sequence(:title) { |n| "Job #{n}" }
    description { "Come work for us and this great opportunity!" }
    country_code { "NL" }
    apply_url { "https://example.com/apply" }
    min_salary { FFaker::Number.between(from: 1.00, to: 5000.00) }
    max_salary { FFaker::Number.between(from: 5001.00, to: 10000.00) }
  end
end
