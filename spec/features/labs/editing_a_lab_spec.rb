require 'spec_helper'

feature "Editing a lab" do

  given(:user) { FactoryGirl.create(:user) }
  given(:lab) { FactoryGirl.create(:lab, workflow_state: 'approved') }

  scenario "as a visitor" do
    visit edit_lab_path(lab)
    expect(page.title).to match('Sign in')
  end

  scenario "as a user" do
    sign_in
    visit edit_lab_path(lab)
    expect(page.status_code).to eq(403)
  end

  feature "as a lab admin" do

    background do
      user.verify!
      user.add_role :admin, lab
      sign_in user
      visit lab_path(lab)
      click_link "Edit Lab Details"
    end

    scenario "with valid details" do
      fill_in "lab_name", with: 'New Name'
      click_button 'Update Lab'
      expect(page).to have_content("Lab was successfully updated")
    end

    scenario "with invalid details" do
      fill_in "lab_name", with: ''
      click_button 'Update Lab'
      expect(page).to have_css(".errors")
    end

  end

end
