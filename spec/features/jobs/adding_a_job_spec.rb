require 'spec_helper'

feature "Adding a job" do

  given(:job) { FactoryBot.create(:job) }

  scenario "as a visitor shows external form link" do
    visit jobs_path
    expect(page).to have_link('New Job Posting')
    expect(page).to have_link(href: /^https?:\/\//)
  end

  scenario "as a visitor needs to sign in" do
    visit new_job_path
    expect(page.title).to match('Sign in')
  end

  scenario "as a verified user is blocked from creating a job" do
    sign_in FactoryBot.create(:user, workflow_state: :verified)
    visit new_job_path
    expect(current_path).to eq(root_path)
  end

  scenario "as a unverified user is blocked from creating a job" do
    sign_in FactoryBot.create(:user, workflow_state: :unverified)
    visit new_job_path
    expect(current_path).to eq(root_path)
  end

  scenario "as an admin" do
    sign_in_superadmin
    visit jobs_path
    click_link "New Job Posting"
    fill_in "Title", with: "Job Posting 2"
    fill_in "Description", with: "3D Printer"
    click_button "Create Job"
    expect(page).to have_content("Job Posting 2")
  end

end
