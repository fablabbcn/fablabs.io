require 'spec_helper'

describe User do

  let(:user) { FactoryGirl.create(:user) }

  describe :unauthenticated do

    it "has show page" do
      visit user_path(user)
      expect(page).to have_css('h1', text: user.full_name)
    end

    it "requires valid credentials to login" do
      visit signin_path
      fill_in "Email", with: 'blahblah@blah.com'
      fill_in "Password", with: "password"
      click_button "Sign in"
      expect(page).to have_content("Invalid email or password")
    end

    it "can signup" do
      visit signup_path
      fill_in 'Username', with: 'john'
      fill_in 'user_first_name', with: 'John'
      fill_in 'user_last_name', with: 'Rees'
      fill_in 'Email', with: 'new@user.com'
      fill_in 'user_password', with: 'password'
      fill_in 'user_password_confirmation', with: 'password'
      click_button "Sign Up"
      expect(page).to have_content "Thanks for signing up"
      expect(last_email.to).to include('new@user.com')
    end

    it "requires all fields to sign up" do
      visit signup_path
      click_button "Sign Up"
      expect(page).to have_css ".errors"
    end

  end

  describe :user do

    it "can signout" do
      signin user
      click_link "Sign out"
      expect(page).to have_link "Sign in"
    end

    it "can edit settings" do
      signin user
      click_link "Settings"
      fill_in "Email", with: "fred@flintstone.com"
      click_button "Update"
      expect(page).to have_content "Settings updated"
    end

    it "needs valid data to update settings" do
      signin user
      click_link "Settings"
      fill_in "Email", with: ""
      click_button "Update"
      expect(page).to have_css ".errors"
    end

    it "shows validate message for unvalidated user" do
      signin user
      expect(page).to have_content("validate your email address")
    end

    it "doesn't show validate message for validated user" do
      user.verify!
      signin user
      expect(page).to_not have_content("validate your email address")
    end

    it "can resend verification email" do
      signin user
      click_link "Resend Verification Email"
      expect(last_email.to).to include(user.email)
      expect(page).to have_content('Thanks')
    end

  end

  describe :admin do

    it "can see backstage link" do
      signin user
      expect(page).to_not have_link('Backstage')
      user.add_role :admin
      visit root_path
      expect(page).to have_link('Backstage')
    end

  end

end
