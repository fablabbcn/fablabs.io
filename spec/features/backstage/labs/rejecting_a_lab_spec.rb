require 'spec_helper'

feature "Rejecting a lab" do

  let(:referee) { FactoryGirl.create(:lab) }
  let(:referee_admin) { FactoryGirl.create(:user) }
  let(:referee_employee) { FactoryGirl.create(:employee, user: referee_admin, lab: referee) }

  let(:lab) { FactoryGirl.create(:lab, referee: referee) }
  let(:lab_admin) { FactoryGirl.create(:user) }
  let(:lab_admin_employee) { FactoryGirl.create(:employee, user: lab_admin, lab: lab) }

  background do
    lab_admin.add_role :admin, lab
    referee_admin.add_role :admin, referee
  end

  scenario "as an admin" do
    sign_in_superadmin
    visit backstage_lab_path(lab)
    click_button "Reject"
    expect(page).to have_content("Lab rejected")
  end

  scenario "as an admin rejecting a rejected lab" do
    sign_in_superadmin
    new_lab = FactoryGirl.create(:lab, referee: referee)
    lab.workflow_state = :rejected
    visit backstage_lab_path(lab)
    expect(page).to_not have_link("Reject")
  end

end
