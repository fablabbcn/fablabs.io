FactoryBot.define do
  factory :organization do
    sequence(:name) { |n| "Organization #{n}" }
    description { FFaker::Lorem.sentence }
    address_1 { FFaker::Address.street_address }
    county { "County" }
    country_code { "es" }
    creator
    kind { Organization::KINDS[0] }
  end
end
