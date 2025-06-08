require 'spec_helper'

feature "Resetting your password" do

  scenario "with a valid passowrd" do
    user = FactoryBot.create(:user)
    recovery = FactoryBot.create(:recovery, user: user, email_or_username: [user.email, user.username].sample)
    visit recovery_url(user.recovery_key)
    #expect(page).to_not have_link('Sign in')
    fill_in 'recovery_user_attributes_password', with: 'newpassword'
    fill_in 'Password confirmation', with: 'newpassword'
    click_button 'Reset Password'
    expect(page).to have_content('Password reset')
    expect(page).to have_link('Sign out')

    # Now test that the recovery key is deleted
    expect(Recovery.find_by(id: recovery.id)).to be_nil
  end

  scenario "with an invalid url" do
    visit recovery_url('invalidkey')
    expect(page).to have_content('no longer valid')
  end

  scenario "with an empty password" do
    user = FactoryBot.create(:user)
    recovery = FactoryBot.create(:recovery, user: user, email_or_username: [user.email, user.username].sample)
    visit recovery_url(user.recovery_key)
    #expect(page).to_not have_link('Sign in')
    click_button 'Reset Password'
    expect(page).to have_content('blank')
  end

end
