require 'spec_helper'

feature "Approving a lab" do

  scenario "as an admin" do
    sign_in_superadmin
    lab = FactoryGirl.create(:lab)
    visit backstage_lab_path(lab)
    click_button "Approve Lab"
    expect(page).to have_content("Lab approved")
    expect(last_email.to).to include(lab.creator.email)
  end

end
