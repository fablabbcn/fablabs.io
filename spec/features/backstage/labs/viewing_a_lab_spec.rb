require 'spec_helper'

feature "Viewing a lab" do

  scenario "as an admin" do
    sign_in_superadmin
    lab = FactoryGirl.create(:lab)
    visit backstage_lab_path(lab)
    expect(page).to have_title(lab.name)
  end

end
