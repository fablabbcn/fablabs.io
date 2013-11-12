# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do

  factory :employee do
    user
    lab
    job_title "Manager"
    description "Manages the Lab"
    started_on "2013-10-04"
    finished_on "2013-11-12"
  end

  factory :discussion do
    title "MyString"
    body "MyText"
    association :discussable, factory: :lab
    creator
    workflow_state "MyString"
  end

  factory :facility do
    lab
    tool
    notes "cool tool"
  end

  factory :link do
    lab
    url "http://www.fablabbcn.org/"
    description "Wordpress Blog"
  end

  factory :featured_image do
    src "http://www.fablabbcn.org/wp-content/uploads/2013/10/012.jpg"
    name "ELEFAB"
    description "A one-of-a-kind elephant creature during a kids' workshop "
    url "http://www.fablabbcn.org/2013/10/elefab-2/"
  end

  factory :lab do
    name "Fab Lab BCN"
    slug "fablabbcn"
    description "A cool lab in Barcelona"
    address_1 "Carrer de Pujades, 102"
    country_code "es"
    creator
  end

  factory :user, aliases: [:creator] do
    first_name "John"
    last_name "Rees"
    sequence(:email) {|n| "john#{n}@bitsushi.com"}
    password "password"
    password_confirmation "password"
  end

  factory :recovery do
    user
    ip '8.8.8.8'
  end

  factory :brand do
    name "Roland"
    url "http://www.rolanddg.com"
  end

  factory :tool do
    name "Modela"
    brand
    description "A general purpose milling machine"
  end

  factory :role_application do
    user
    lab
    description "I work here"
  end

end
