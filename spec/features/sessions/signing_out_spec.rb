require 'spec_helper'

feature "Signing out" do

  scenario "as a signed in user" do
    sign_in
    click_link "Sign out"
    expect(page).to have_link "Sign In"
  end

end
