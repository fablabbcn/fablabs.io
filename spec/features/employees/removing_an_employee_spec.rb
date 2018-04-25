require 'spec_helper'

feature "Removing an employee" do

  given(:lab) { FactoryGirl.create(:lab, workflow_state: 'approved') }
  given(:user) { FactoryGirl.create(:user, first_name: "Homer", last_name: "Simpson") }
  given(:employee) { FactoryGirl.create(:employee, user: user, lab: lab, job_title: "Nuclear Safety Inspector") }

  skip "as a user without authority" do
    employee.approve!
    sign_in
    visit lab_employees_path(lab)
    expect(page.status_code).to eq(403)
  end

  skip "as a user removing themselves" do
    employee.approve!
    sign_in user
    visit lab_employees_path(lab)
    click_link "Remove"
    expect(current_path).to eq(lab_path(lab))
    expect(page).to_not have_link("Homer Simpson")
    expect(page).to have_link("I work here")
  end

  scenario "as a superadmin removing another user" do
    employee.approve!
    sign_in_superadmin
    visit lab_employees_path(lab)
    click_link "Remove"
    expect(current_path).to eq(lab_path(lab))
    expect(page).to_not have_link("Homer Simpson")
    expect(page).to have_link("I work here")
  end

end
