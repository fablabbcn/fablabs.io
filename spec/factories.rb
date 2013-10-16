# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do

  factory :lab do
    name "Fab Lab BCN"
    slug "fablabbcn"
    description "A cool lab in Barcelona"
    creator
  end

  factory :user, aliases: [:creator] do
    first_name "John"
    last_name "Rees"
    email "john@bitsushi.com"
    password "password"
    password_confirmation "password"
  end

end
