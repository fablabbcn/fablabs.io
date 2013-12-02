require 'spec_helper'

feature "Applying to be an employee" do

  given(:lab) { FactoryGirl.create(:lab, workflow_state: 'approved') }
  given(:user) { FactoryGirl.create(:user, first_name: "Homer", last_name: "Simpson") }
  given(:employee) { FactoryGirl.create(:employee, user: user, lab: lab, job_title: "Nuclear Safety Inspector") }

  scenario "as visitor" do
    visit lab_url(lab)
    expect(page).to_not have_link("I work here")
  end

  scenario "as unverified user" do
    sign_in
    visit lab_url(lab)
    expect(page).to_not have_link("I work here")
  end

  scenario "as a verified user" do
    admin = FactoryGirl.create(:user)
    admin.add_role :admin

    user.verify!
    sign_in user
    visit lab_url(lab)
    click_link "I work here"
    fill_in "Job title", with: "King"
    fill_in "employee_description", with: "I sit on a throne"
    click_button "Send Application"
    expect(page).to have_content("Thank you for applying")
    expect(last_email.to).to include(lab.admins.last.email)
  end

  scenario "as an admin"

end
