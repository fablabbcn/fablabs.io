# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryBot.define do
  factory :oauth_application, class: Doorkeeper::Application do
    sequence(:name) { |n| "application_name_#{n}" }
    # redirect_uri 'urn:ietf:wg:oauth:2.0:oob'
    owner
    redirect_uri 'https://localhost:3000/'
  end
end
