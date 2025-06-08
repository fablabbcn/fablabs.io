require 'spec_helper'

feature "Requesting a recovery" do

  scenario "as a user, with a valid application" do
    user = FactoryBot.create(:user, email: 'john@bitsushi.com', username: 'johnrees')
    visit signin_path
    click_link "Forgot"
    fill_in :recovery_email_or_username, with: [user.email, user.username].sample
    click_button 'Reset Password'
    expect(page).to have_content('recovery instructions should appear in your inbox soon.')
    expect(last_email.to).to include('john@bitsushi.com')
    expect(Recovery.count).to eq(1)
    expect(Recovery.exists?(user: user)).to be true
  end

  scenario "as an unregistered user" do
    visit signin_path
    click_link "Forgot"
    fill_in :recovery_email_or_username, with: 'steve@jobs.com'
    click_button 'Reset Password'
    # Always say we going to send
    expect(page).to have_content('recovery instructions should appear in your inbox soon.')
    expect(Recovery.count).to eq(0)
  end

end
