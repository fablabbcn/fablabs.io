require 'spec_helper'

feature "Viewing a user profile" do

  given(:user) { FactoryGirl.create(:user) }

  scenario "as a visitor" do
    visit user_path(user)
    expect(page).to have_css('h1', text: user.full_name)
  end

  scenario "as the user in question"

end
