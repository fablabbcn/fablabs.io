require 'spec_helper'

feature "Viewing a user" do

  scenario "as an admin" do
    sign_in_superadmin
    user = FactoryBot.create(:user)
    visit backstage_user_path(user)
    expect(page).to have_title(user.full_name)
  end

end
