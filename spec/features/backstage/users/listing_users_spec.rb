require 'spec_helper'

feature "Listing users" do

  scenario "as an admin" do
    sign_in_superadmin
    visit backstage_users_path
    expect(page).to have_title('Users')
  end

end
