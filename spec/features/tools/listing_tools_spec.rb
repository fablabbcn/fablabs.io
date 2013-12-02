require 'spec_helper'

feature "Listing tools" do

  given(:tool) { FactoryGirl.create(:tool, name: "Shopbot") }

  scenario "as a visitor" do
    visit tools_path
    expect(page.status_code).to eq(403)
  end

  scenario "as a user" do
    sign_in
    visit tools_path
    expect(page.status_code).to eq(403)
  end

  scenario "as an admin" do
    sign_in_superadmin
    tool.reload
    visit tools_path
    expect(page).to have_title('Tools')
    expect(page).to have_link('Shopbot')
  end

end
