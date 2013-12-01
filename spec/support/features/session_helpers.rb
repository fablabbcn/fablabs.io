# spec/support/features/session_helpers.rb
module Features
  module SessionHelpers

    def sign_up_as user
      visit signup_path
      fill_in 'user_first_name', with: user.first_name
      fill_in 'user_last_name', with: user.last_name
      fill_in 'Username', with: user.username
      fill_in 'Email', with: user.email
      fill_in 'user_password', with: user.password
      fill_in 'user_password_confirmation', with: user.password_confirmation
      click_button 'Sign Up'
    end

    def sign_in(user = nil)
      user ||= FactoryGirl.create(:user)
      visit signin_path
      fill_in "Email or Username", with: [user.email,user.username].sample
      fill_in "Password", with: "password"
      click_button "Sign in"
    end

    def sign_in_admin
      admin = FactoryGirl.create(:user)
      admin.add_role :admin
      sign_in admin
    end

  end
end
