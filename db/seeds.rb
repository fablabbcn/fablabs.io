# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

unless Rails.env.development?
  puts "No seeds for mode: #{Rails.env}"
  exit
end

User.find_or_create_by(username: 'user') do |user|
  user.email = 'user@user.local'
  user.password= 'password'
  user.password_confirmation= 'password'
  user.first_name= 'User'
  user.last_name= 'Userson'
  user.agree_policy_terms= true
end

User.find_or_create_by(username: 'admin') do |user|
  user.email = 'admin@admin.local'
  user.password= 'password'
  user.password_confirmation= 'password'
  user.first_name= 'Admin'
  user.last_name= 'Adminerson'
  user.agree_policy_terms= true
  user.add_role :superadmin
end

100.times do
Organization.create!(
  name: Faker::Product.product,
  slug: Faker::Product.letters(3),
  address_1: Faker::Address.street_address,
  description: Faker::Lorem.sentence,
  county: "County",
  country_code: "es",
  kind: Organization::KINDS[0]
)
end

RefereeApprovalProcess.create!(
  referred_lab_id: 2,
  referee_lab_id: 2
)



# ActiveRecord::RecordInvalid: Validation failed: Referee approval processes can't be blank,
# Referee approval processes is the wrong length (should be 3 characters)
100.times do
  @lab = Lab.create!(
  name: "MyLab#{Lab.count}",
  kind: Lab::Kinds[1],
  country_code: 'IS',
  address_1: 'MyStreet 24',
  network: true,
  tools: true,
  programs: true,
  workflow_state: 'approved',
  latitude: 64.963,
  longitude: 19.0208
  #referee_id: 1
  )
end

Brand.create!(
  name: 'A Brand',
  description: 'brand'
)

Thing.create!(
  name: 'Something',
  description: 'A thing',
  brand: Brand.first,
  #creator:
)

Facility.find_or_create_by(
  lab: Lab.first,
  thing: Thing.first
)

Employee.find_or_create_by(
  user: User.first,
  lab: Lab.first,
  job_title: Faker::Job.title
)

Document.create!(

)

Event.create!(
  name: 'myEvent',
  description: 'some description',
  lab: Lab.first
)
