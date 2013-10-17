require 'spec_helper'

describe User do

  describe "UNauthenticated user" do

    it "requires valid credentials to login" do
      visit signin_path
      fill_in "Email", with: 'blahblah@blah.com'
      fill_in "Password", with: "password"
      click_button "Sign in"
      expect(page).to have_content("Invalid email or password")
    end

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

    it "needs valid data to update settings" do
      signin FactoryGirl.create(:user)
      click_link "Settings"
      fill_in "First name", with: ""
      click_button "Update"
      page.should have_content "error"
    end

  end

end
