require 'spec_helper'

feature "Editing a user" do

  let(:user) { FactoryBot.create(:user, first_name: "Eric", last_name: "Cartman") }

  scenario "as a visitor" do
    visit edit_backstage_user_path(user)
    expect(page.title).to match('Sign in')
  end

  scenario "as a user" do
    sign_in
    visit edit_backstage_user_path(user)
    expect(current_path).to eq(root_path)
  end

  scenario "as an admin" do
    user.reload
    sign_in_superadmin
    visit backstage_users_path
    click_link "Eric Cartman"
    click_link "Edit User"
    fill_in "First name", with: "Randy"
    fill_in "Last name", with: "Marsh"
    click_button "Save"
    expect(page).to have_content("User updated")
    expect(page).to have_content("Randy Marsh")
  end

  scenario "as an admin with invalid details" do
    sign_in_superadmin
    visit edit_backstage_user_path(user)
    fill_in "First name", with: ""
    click_button "Save"
    expect(page).to have_css(".errors")
  end

end
