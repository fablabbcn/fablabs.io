# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryBot.define do
  factory :step do
    title           { "First step" }
    description     { "This is the first step of this project." }
    position        { 1 }
    project_id      { 1 }
  end
end
