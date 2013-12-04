require 'spec_helper'

feature "Tracking an activity" do

  given(:lab) { FactoryGirl.create(:lab) }

  scenario "admin updates a lab" do
    sign_in_superadmin
    visit edit_lab_path(lab)
    fill_in "Name", with: "New name"
    click_button "Update"
    visit activity_path
    expect(page).to have_content("#{User.last} updated New name")
  end

  scenario "user signs up" do
    sign_up_as FactoryGirl.build(:user)
    visit activity_path
    expect(page).to have_content("#{User.last} signed up")
  end

  scenario "employee is approved" do
    sign_in_superadmin
    lab = FactoryGirl.create(:lab)
    lab.approve!
    employee = FactoryGirl.create(:employee, lab: lab)
    visit lab_employees_path(lab)
    click_button "Approve"
    visit activity_path
    expect(page).to have_content("#{employee.user} was added as #{employee.job_title} at #{lab}")
  end

  pending "employee applies"
  pending "employee is removed"
  pending "employee is updated"

end