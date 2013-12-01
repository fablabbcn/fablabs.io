require 'spec_helper'

feature "Listing labs" do

  let(:lab) { FactoryGirl.create(:lab, name: "iaac") }

  scenario "as a visitor" do
    visit backstage_labs_path
    expect(page.title).to match('Sign in')
  end

  scenario "as a user" do
    sign_in
    visit backstage_labs_path
    expect(current_path).to eq(labs_path)
  end

  scenario "as an admin" do
    lab.reload
    sign_in_admin
    visit backstage_labs_path
    expect(page.title).to match("Labs")
    expect(page).to have_link("iaac")
  end

end