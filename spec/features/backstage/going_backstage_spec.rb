require 'spec_helper'

feature "Going backstage" do

  scenario "as a visitor" do
    visit backstage_root_path
    expect(page.title).to match('Sign in')
  end

  scenario "as a user" do
    sign_in
    visit backstage_root_path
    expect(current_path).to eq(root_path)
    expect(page).to have_content("Not authorized")
  end

  scenario "as an admin" do
    sign_in_superadmin
    visit backstage_root_path
    expect(page.title).to match('Labs')
  end

end
