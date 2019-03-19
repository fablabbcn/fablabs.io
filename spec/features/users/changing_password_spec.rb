require 'spec_helper'

feature "Changing the password" do

  scenario "as a visitor" do
    user = FactoryBot.create(:user)
    visit password_path(user)
    expect(page.title).to include("Sign in")
  end

  scenario "as a user" do
    user = FactoryBot.create(:user)
    sign_in user
    visit user_path(user)
    click_link "Change Password"
    fill_in 'user[password]', with: "password001"
    fill_in 'user[password_confirmation]', with: "password001"
    click_button "Update"
    expect(page).to have_content "Password updated"
  end

  scenario "as a user with non matching passwords" do
    user = FactoryBot.create(:user)
    sign_in user
    visit user_path(user)
    click_link "Change Password"
    fill_in 'user[password]', with: "blablabla"
    fill_in 'user[password_confirmation]', with: "blublublub"
    click_button "Update"
    expect(page).to have_css ".errors"
    expect(page).to have_content "Passwords do not match"
  end

  scenario "as a user with invalid data" do
    user = FactoryBot.create(:user)
    sign_in user
    visit user_path(user)
    click_link "Change Password"
    fill_in 'user[password]', with: "bla"
    fill_in 'user[password_confirmation]', with: "bla"
    click_button "Update"
    expect(page).to have_css ".errors"
  end


end
