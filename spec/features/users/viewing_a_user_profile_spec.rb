require 'spec_helper'

feature "Viewing a user profile" do

  given(:user) { FactoryGirl.create(:user) }

  scenario "as a visitor" do
    visit user_path(user)
    expect(page).to have_css('h1', text: user.full_name)
    expect(page).to_not have_link("Edit Profile")
  end

  scenario "as the user in question" do
    sign_in user
    visit user_path(user)
    click_link "Edit Profile"
    expect(current_path).to eq(settings_path)
  end

end
