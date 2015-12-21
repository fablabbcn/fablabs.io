require 'spec_helper'

feature "Removing a lab" do

  scenario "as an admin" do
    sign_in_superadmin
    lab = FactoryGirl.create(:lab, workflow_state: 'approved')
    visit backstage_lab_path(lab)
    click_button "Remove"
    expect(page).to have_content("Lab removed")
    expect(last_email.to).to include(lab.creator.email)
  end

end
