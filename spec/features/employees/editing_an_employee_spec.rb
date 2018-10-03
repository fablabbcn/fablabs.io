require 'spec_helper'

feature "Editing an employee" do

  given(:lab) { FactoryBot.create(:lab, workflow_state: "approved") }
  given(:user) { FactoryBot.create(:user) }
  given(:employee) { FactoryBot.create(:employee, lab: lab, user: user) }
  given(:admin) { FactoryBot.create(:user) }

  scenario "as employee with valid data" do
    user.verify!
    sign_in user
    visit edit_employee_path(employee)
    fill_in "Job title", with: "Maestro"
    click_button "Update"
    expect(page).to have_content("Employee updated")
  end

  scenario "as employee with invalid data" do
    user.verify!
    sign_in user
    visit edit_employee_path(employee)
    fill_in "Job title", with: ""
    click_button "Update"
    expect(page).to have_css(".errors")
  end

  scenario "as lab admin" do
    sign_in_superadmin
    visit edit_employee_path(employee)
    fill_in "Job title", with: "Jester"
    click_button "Update"
    expect(page).to have_content("Employee updated")
  end

  scenario "as lab admin with invalid data" do
    sign_in_superadmin
    visit edit_employee_path(employee)
    fill_in "Job title", with: ""
    click_button "Update"
    expect(page).to have_css(".errors")
  end

end
