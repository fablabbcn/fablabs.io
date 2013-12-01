require 'spec_helper'

feature "Managing employees" do

  given(:lab) { FactoryGirl.create(:lab, workflow_state: 'approved') }
  given(:user) { FactoryGirl.create(:user, first_name: "Homer", last_name: "Simpson") }
  given(:employee) { FactoryGirl.create(:employee, user: user, lab: lab, job_title: "Nuclear Safety Inspector") }

  scenario "as an admin" do
    sign_in_admin
    employee.reload
    visit lab_path(lab)
    expect(page).to_not have_link("Homer Simpson")

    click_link "edit-employees"
    expect(page).to have_content "Homer Simpson"
    click_button "Approve"
    expect(current_path).to include(lab_path(lab))
    expect(page).to have_content("Nuclear Safety Inspector")
    expect(page).to have_link("Homer Simpson")

    expect(last_email.to).to include(user.email)
  end

end
