require 'spec_helper'

feature "Editing a job" do

  let(:job) { FactoryBot.create(:job) }

  scenario "as a visitor" do
    visit job_path(job)
    expect(page).to_not have_link("Edit")
    visit edit_job_path(job)
    expect(current_path).to eq(signin_path)
  end

  %w(unverified verified).each do |state|
    scenario "as a #{state} user" do
      sign_in FactoryBot.create(:user, workflow_state: state)
      visit job_path(job)
      visit edit_job_path(job)
      expect(current_path).to eq(root_path)
    end
  end

  scenario "as an admin", skip: "not implemented yet" do
    sign_in_superadmin
    visit job_path(job)
    click_link "Edit"
    fill_in "Title", with: "SHOP BOT"
    click_button "Update Job"
    expect(page).to have_css("h1", text: "SHOP BOT")
  end

  scenario "as an admin with invalid data", skip: "not implemented yet" do
    sign_in_superadmin
    visit edit_job_path(job)
    fill_in "Title", with: ""
    click_button "Update Job"
    expect(page).to have_css(".errors")
  end

end
