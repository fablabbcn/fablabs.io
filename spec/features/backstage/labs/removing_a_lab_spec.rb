require 'spec_helper'

feature "Removing a lab" do

  let(:lab_admin) { FactoryGirl.create(:user) }
  let(:referee) { FactoryGirl.create(:lab) }
  let(:referee_employee) { FactoryGirl.create(:employee, user: referee, lab: referee) }
  let(:lab) { FactoryGirl.create(:lab, referee: referee, workflow_state: 'approved') }

  scenario "as an admin" do
    sign_in_superadmin
    visit backstage_lab_path(lab)
    click_button "Remove"
    expect(page).to have_content("Lab removed")
  end

end
