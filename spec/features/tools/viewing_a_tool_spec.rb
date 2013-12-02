require 'spec_helper'

feature "Viewing a tool" do

  given(:tool) { FactoryGirl.create(:tool) }

  scenario "as a visitor" do
    visit tool_path(tool)
    expect(page.status_code).to eq(403)
  end

  scenario "as a user" do
    sign_in
    visit tool_path(tool)
    expect(page.status_code).to eq(403)
  end

  scenario "as an admin" do
    sign_in_superadmin
    visit tool_path(tool)
    expect(page).to have_title(tool.name)
    expect(page).to have_css('h1', text: tool.name)
  end

end
