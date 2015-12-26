require 'spec_helper'

feature "Adding a lab" do

  scenario "as a visitor" do
    visit new_lab_path
    expect(page.title).to match('Sign in')
  end

  scenario "as an unverified user" do
    sign_in
    visit new_lab_path
    # expect(page.status_code).to eq(403)
  end

  feature "as a verified user" do

    given(:user) { FactoryGirl.create(:user) }

    background do
      user.verify!
      sign_in user
      visit labs_path
      click_link "Add Lab"
    end

    scenario "as a user with valid details" do
      admin = FactoryGirl.create(:user)
      admin.add_role :superadmin
      choose "lab_kind_2"
      choose "lab_tools_1"
      choose "lab_network_1"
      choose "lab_programs_1"
      fill_in 'Name', with: 'New Lab'
      fill_in 'lab_description', with: 'An awesome place'
      fill_in 'lab_address_1', with: 'Mars'
      fill_in 'lab_links_attributes_0_url', with: 'http://www.newlab.com'
      fill_in 'lab_employees_attributes_0_job_title', with: 'Spaceman'
      fill_in 'lab_employees_attributes_0_description', with: 'I explore the surface'
      fill_in 'County', with: 'County'
      select 'United Kingdom', from: 'Country'
      fill_in 'Slug', with: 'newlab'
      click_button 'Add Lab'
      expect(page).to have_content "Thanks"

      emails = ActionMailer::Base.deliveries.map(&:to).flatten
      expect(emails).to eq([user.email, admin.email])
    end

    scenario "as a user with invalid details" do
      fill_in 'Name', with: 'No details'
      click_button 'Add Lab'
      expect(page).to have_css ".errors"
    end

  end

end
