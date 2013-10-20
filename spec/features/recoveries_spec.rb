require 'spec_helper'

describe 'recoveries' do

  it "emails user when requesting password recovery" do
    user = FactoryGirl.create(:user, email: 'john@bitsushi.com')
    visit signin_path
    click_link "Forgotten Password?"
    fill_in :recovery_email, with: 'john@bitsushi.com'
    click_button 'Reset Password'
    expect(page).to have_content('Recovery instructions should appear in your inbox soon.')
    expect(last_email.to).to include('john@bitsushi.com')
  end

  it "alerts user if email does not exist in system" do
    visit signin_path
    click_link "Forgotten Password?"
    fill_in :recovery_email, with: 'steve@jobs.com'
    click_button 'Reset Password'
    expect(page).to have_content('Sorry, we have no user with that email address')
  end

  it "can only reset with valid url" do
    expect{visit recovery_url('invalidkey')}.to raise_error(ActiveRecord::RecordNotFound)
  end

  it "can cannot use empty password" do
    user = FactoryGirl.create(:user)
    recovery = FactoryGirl.create(:recovery, user: user, email: user.email)
    visit recovery_url(user.recovery_key)
    expect(page).to_not have_link('Sign in')
    click_button 'Reset Password'
    expect(page).to have_content('blank')
  end

  it "can reset password from url" do
    user = FactoryGirl.create(:user)
    recovery = FactoryGirl.create(:recovery, user: user, email: user.email)
    visit recovery_url(user.recovery_key)
    expect(page).to_not have_link('Sign in')
    fill_in 'recovery_user_attributes_password', with: 'newpassword'
    fill_in 'Password confirmation', with: 'newpassword'
    click_button 'Reset Password'
    expect(page).to have_content('Password reset')
    expect(page).to have_link('Sign Out')
  end

end
