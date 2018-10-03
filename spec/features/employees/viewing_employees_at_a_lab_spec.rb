require 'spec_helper'

feature "Viewing employees at a lab" do

  given(:lab) { FactoryBot.create(:lab, workflow_state: 'approved') }
  given(:user) { FactoryBot.create(:user, first_name: "Homer", last_name: "Simpson") }
  given(:employee) { FactoryBot.create(:employee, user: user, lab: lab, job_title: "Nuclear Safety Inspector") }

  scenario "unverified employees" do
    employee.reload
    visit lab_url(lab)
    expect(page).to_not have_link("Homer Simpson")
  end

  scenario "approved employees" do
    employee.approve!
    visit lab_url(lab)
    expect(page).to have_link("Homer Simpson")
    expect(page).to have_content("Nuclear Safety Inspector")
  end

  scenario "as an applicant" do
    employee.reload
    sign_in user
    visit lab_url(lab)
    expect(page).to have_content("Applied")
    expect(page).to_not have_content("Nuclear Safety Inspector")
  end

end
