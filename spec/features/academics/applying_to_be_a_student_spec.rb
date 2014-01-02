# require 'spec_helper'

# feature "Applying to be a student" do

#   given(:lab) { FactoryGirl.create(:lab, workflow_state: 'approved') }
#   given(:user) { FactoryGirl.create(:user, first_name: "Homer", last_name: "Simpson") }
#   given(:academic) { FactoryGirl.create(:academic, user: user, lab: lab) }

#   scenario "as visitor" do
#     visit lab_url(lab)
#     expect(page).to have_link("I did the fab academy here")
#   end

#   scenario "as unverified user" do
#     sign_in
#     visit lab_url(lab)
#     expect(page).to have_link("I did the fab academy here")
#   end

#   scenario "as a verified user" do
#     admin = FactoryGirl.create(:user)
#     admin.add_role :superadmin
#     user.verify!
#     sign_in user
#     visit lab_url(lab)
#     click_link "I did the fab academy here"
#     select "2013", from: "Year"
#     # fill_in "employee_description", with: "I sit on a throne"
#     click_button "Send Application"
#     expect(page).to have_content("Thank you for applying")
#     expect(last_email.to).to include(lab.admins.last.email)
#   end

#   scenario "as a superadmin" do
#     sign_in_superadmin
#     visit lab_url(lab)
#     expect(page).to have_link("I did the fab academy here")
#   end

# end
