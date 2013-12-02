require 'spec_helper'

feature "Rejecting a lab" do

  scenario "as an admin" do
    sign_in_superadmin
    lab = FactoryGirl.create(:lab)
    visit backstage_lab_path(lab)
    click_button "Reject Lab"
    expect(page).to have_content("Lab rejected")
    expect(last_email.to).to include(lab.creator.email)
  end

  scenario "as an admin rejecting a rejected lab" do
    sign_in_superadmin
    lab = FactoryGirl.create(:lab)
    lab.reject!
    visit backstage_lab_path(lab)
    expect(page).to_not have_link("Reject Lab")
  end

end
