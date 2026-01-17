require 'spec_helper'

feature "Searching labs" do

  let(:lab) { FactoryBot.create(:lab, name: "iaac") }

  scenario "as a visitor" do
    visit backstage_labs_path
    expect(page.title).to match('Sign in')
  end

  scenario "as a user" do
    sign_in
    visit backstage_labs_path
    expect(current_path).to eq(root_path)
  end

  scenario "as an admin" do
    lab.reload
    sign_in_superadmin
    visit backstage_labs_path
    expect(page.title).to match("Labs")
    fill_in 'q_name_or_city_cont', with: 'iaac' #
    click_button "Filter"
    expect(page).to have_link("iaac")
  end

end