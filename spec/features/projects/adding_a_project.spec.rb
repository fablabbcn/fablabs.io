require 'spec_helper'

feature "Adding a project" do

  scenario "as a visitor" do
    visit new_project_path
    expect(page.title).to match('Sign in')
  end

  scenario "as an unverified user" do
    sign_in
    visit new_project_path
    # expect(page.status_code).to eq(403)
  end

  feature "as a verified user" do

    given(:user) { FactoryBot.create(:user) }

    background do
      user.verify!
      sign_in user
      visit projects_path
      click_link "Add a Project"
    end

    scenario "as a user with valid details" do
      user = FactoryBot.create(:user)
      fill_in 'project_title', with: 'My fab project'
      fill_in 'project_description', with: 'An awesome project'
      click_button 'Create Project'
      expect(page).to have_content 'Thanks'

    end

    scenario "add project steps" do
      user = FactoryBot.create(:user)
      fill_in 'project_title', with: 'My fab project'
      fill_in 'project_description', with: 'An awesome project'
      click_link 'Add another step'
      fill_in 'project_steps_title', with: 'First step'
      fill_in 'project_steps_description', with: 'This is the description for the first step'
      click_button 'Create Project'
      expect(page).to have_content 'Thanks'
      expect(page).to have_content 'This is the description for the first step'
    end


end
