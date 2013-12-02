require 'spec_helper'

feature "Signing in" do

  scenario "as a signed in user" do
    sign_in
    visit signin_path
    expect(current_path).to eq(labs_path)
    expect(page).to have_content("already signed in")
  end

end
