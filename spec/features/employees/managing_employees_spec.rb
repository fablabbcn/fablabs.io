require 'spec_helper'

feature "Managing employees" do

  given(:lab) { FactoryBot.create(:lab, workflow_state: 'approved') }
  given(:user) { FactoryBot.create(:user, first_name: "Homer", last_name: "Simpson") }
  given(:employee) { FactoryBot.create(:employee, user: user, lab: lab, job_title: "Nuclear Safety Inspector") }

  scenario "unverified lab" do
    superadmin = FactoryBot.create(:user)
    superadmin.add_role :superadmin
    lab.remove(superadmin)
    sign_in_superadmin
    expect{visit lab_employees_path(lab)}.to raise_error ActiveRecord::RecordNotFound
  end

  scenario "as an admin" do
    sign_in_superadmin
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
