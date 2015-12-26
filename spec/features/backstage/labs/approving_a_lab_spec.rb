require 'spec_helper'

feature "Approving a lab" do

  let(:lab_admin) { FactoryGirl.create(:user) }
  let(:referee) { FactoryGirl.create(:lab) }
  let(:referee_employee) { FactoryGirl.create(:employee, user: referee, lab: referee) }
  let(:lab) { FactoryGirl.create(:lab, referee: referee) }

  scenario "as an admin" do
    sign_in_superadmin
    visit backstage_lab_path(lab)
    click_button "Approve"
    expect(page).to have_content("Lab approved")
  end

end
