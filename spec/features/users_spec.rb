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
      page.should have_content "Thanks for signing up"
    end

    it "requires all fields to sign up" do
      visit signup_path
      click_button "Sign Up"
      page.should have_content "errors prohibited"
    end

  end

end
