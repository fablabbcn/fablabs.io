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

end