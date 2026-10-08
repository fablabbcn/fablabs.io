require 'spec_helper'

feature "Listing employees" do

  let(:lab) { FactoryBot.create(:lab, workflow_state: :approved) }
  let!(:employee) { FactoryBot.create(:employee, job_title: "machine-worker", lab: lab) }

  scenario "as a visitor" do
    visit backstage_employees_path
    expect(page.title).to match('Sign in')
  end

  scenario "as a user" do
    sign_in
    visit backstage_employees_path
    expect(current_path).to eq(root_path)
  end

  scenario "as an admin" do
    sign_in_superadmin
    visit backstage_employees_path
    expect(page.title).to match("Employees")
    expect(page).to have_content("machine-worker")
  end

end
