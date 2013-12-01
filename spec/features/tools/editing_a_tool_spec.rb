require 'spec_helper'

feature "Editing a tool" do

  let(:tool) { FactoryGirl.create(:tool) }

  scenario "as a visitor"

  scenario "as a user"

  scenario "as an admin" do
    sign_in_admin
    visit tool_path(tool)
    click_link "Edit"
    fill_in "Name", with: "SHOP BOT"
    click_button "Update Tool"
    expect(page).to have_css("h1", text: "SHOP BOT")
  end

  scenario "as an admin with invalid data" do
    sign_in_admin
    visit edit_tool_path(tool)
    fill_in "Name", with: ""
    click_button "Update Tool"
    expect(page).to have_css(".errors")
  end

end
