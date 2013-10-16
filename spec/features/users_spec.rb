require 'spec_helper'

describe User do

  describe "UNauthenticated user" do

    it "can signup" do
      visit signup_path
      fill_in 'First name', with: 'John'
      fill_in 'Last name', with: 'Rees'
      fill_in 'Email', with: 'john@bitsushi.com'
      fill_in 'user_password', with: 'password'
      fill_in 'user_password_confirmation', with: 'password'
      click_button "Sign Up"
      expect(page).to have_content "Thanks for signing up"
    end

    it "requires all fields to sign up" do
      visit signup_path
      click_button "Sign Up"
      expect(page).to have_content "errors prohibited"
    end

  end

  describe "authenticated user" do

    it "can signout" do
      signin FactoryGirl.create(:user)
      click_link "Sign Out"
      page.should have_link "Sign In"
    end

    it "can edit settings" do
      signin FactoryGirl.create(:user)
      click_link "Settings"
      fill_in "First name", with: "Frank"
      click_button "Update"
      page.should have_content "Settings updated"
    end

  end

end
