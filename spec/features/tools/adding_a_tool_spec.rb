require 'spec_helper'

feature "Adding a tool" do

  given(:tool) { FactoryGirl.create(:tool, name: 'Shopbot') }

  scenario "as a visitor" do
    visit tools_path
    expect(page).to_not have_link("New Tool")
    visit new_tool_path
    expect(page.status_code).to eq(403)
  end

  %w(unverified verified).each do |state|
    scenario "as a #{state} user" do
      sign_in FactoryGirl.create(:user, workflow_state: state)
      visit tools_path
      expect(page).to_not have_link("New Tool")
      visit new_tool_path
      expect(page.status_code).to eq(403)
    end
  end

  scenario "as an admin" do
    sign_in_admin
    visit tools_path
    click_link "New Tool"
    fill_in "Name", with: "Replicator 2"
    fill_in "Description", with: "3D Printer"
    click_button "Create Tool"
    expect(page).to have_css("h1", text: "Replicator 2")
  end

end
