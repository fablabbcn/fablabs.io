# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryBot.define do

  factory :lab, aliases: [:linkable, :trackable] do
    sequence(:name) { |n| "Fab Lab #{n}" }
    sequence(:slug) { |n| "fablab#{n}" }
    email { FFaker::Internet.email }
    description { FFaker::Lorem.sentence }
    address_1 { FFaker::Address.street_address }
    improve_approval_application { FFaker::Lorem.sentence }
    county { "County" }
    country_code { "es" }
    network { true }
    programs { true }
    tools { true }
    kind { :fab_lab }
    referee_id { 1 }
    creator
  end

  factory :repeat do
    event
    year { 2013 }
    month { 0 }
    day { 1 }
    week { 1 }
    weekday { 1 }
  end

  factory :coupon do
    user
    description { "Fab 10 Discount Code" }
    value { 300 }
  end

  factory :academic do
    user
    lab
    started_in { 2012 }
    approver
  end

  factory :page do
    title { "Tutorial #{1}" }
    content { "this is a tutorial" }
    published { false }
  end

  factory :event do
    # type ""
    sequence(:name) { |n| "Event #{n}" }
    description { "An Open Day" }
    lab
    creator
    starts_at { Time.zone.now + 1.day }
    ends_at { Time.zone.now + 1.day + 2.hours }
  end

  factory :activity do
    actor
    creator
    action { "create" }
    trackable
  end

  factory :admin_application do
    applicant
    lab
    notes { "MyText" }
  end

  factory :comment do
    author
    commentable
    body { "MyText" }
  end

  factory :employee do
    user
    lab
    job_title { "Manager" }
    description { "Manages the Lab" }
    started_on { "2013-10-04" }
    finished_on { "2013-11-12" }
  end

  factory :discussion do
    title { "MyString" }
    body { "MyText" }
    association :discussable, factory: :lab
    creator
    workflow_state { "MyString" }
  end

  factory :facility do
    lab
    association :thing, factory: :machine
    notes { "cool machine" }
  end

  factory :link do
    linkable
    url { "http://www.fablabbcn.org/" }
    description { "Wordpress Blog" }
  end

  factory :featured_image do
    src { "http://www.fablabbcn.org/wp-content/uploads/2013/10/012.jpg" }
    name { "ELEFAB" }
    description { "A one-of-a-kind elephant creature during a kids' workshop " }
    url { "http://www.fablabbcn.org/2013/10/elefab-2/" }
  end

  factory :user, aliases: [:admin, :creator, :author, :applicant, :actor, :approver,:owner] do
    sequence(:username) {|n| "user#{n}"}
    first_name { "John" }
    last_name { "Rees" }
    sequence(:email) {|n| "john#{n}@bitsushi.com"}
    password { "password" }
    password_confirmation { "password" }
    agree_policy_terms { true }
  end




  factory :recovery do
    user
    ip { '8.8.8.8' }
  end

  factory :brand do
    name { "Roland" }
  end

  factory :machine, aliases: [:commentable] do
    name { "GX-24" }
    brand
    description { "A reliable tool for producing banners, store displays, informational signs, backlit displays, flock heat transfers and almost any other cutting application." }
  end

  factory :role_application do
    user
    lab
    description { "I work here" }
  end

end
