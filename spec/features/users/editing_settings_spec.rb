require 'spec_helper'

feature "Editing settings" do

  scenario "as a visitor" do
    user = FactoryBot.create(:user)
    visit edit_user_path(user)
    expect(page.title).to include("Sign in")
  end

  scenario "as a user" do
    sign_in
    click_link "Settings"
    fill_in "Email", with: "fred@flintstone.com"
    click_button "Update"
    expect(page).to have_content "Settings updated"
  end

  scenario "as a user with invalid data" do
    sign_in
    click_link "Settings"
    fill_in "Email", with: ""
    click_button "Update"
    expect(page).to have_css ".errors"
  end

end