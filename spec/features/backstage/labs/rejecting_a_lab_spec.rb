require 'spec_helper'

feature "Rejecting a lab" do

  let(:referee) { FactoryBot.create(:lab) }
  let(:referee_admin) { FactoryBot.create(:user) }
  let(:referee_employee) { FactoryBot.create(:employee, user: referee_admin, lab: referee) }

  let(:lab) { FactoryBot.create(:lab, :unverified, :unapproved, referee: referee) }
  let(:lab_admin) { FactoryBot.create(:user) }
  let(:lab_admin_employee) { FactoryBot.create(:employee, user: lab_admin, lab: lab) }

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
    new_lab = FactoryBot.create(:lab, referee: referee)
    lab.workflow_state = :rejected
    visit backstage_lab_path(lab)
    expect(page).to_not have_link("Reject")
  end

end
