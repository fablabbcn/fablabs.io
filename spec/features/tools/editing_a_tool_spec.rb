require 'spec_helper'

feature "Editing a machine" do

  let(:machine) { FactoryGirl.create(:machine) }

  scenario "as a visitor"

  scenario "as a user"

  scenario "as an admin" do
    sign_in_superadmin
    visit machine_path(machine)
    click_link "Edit"
    fill_in "Name", with: "SHOP BOT"
    click_button "Update Machine"
    expect(page).to have_css("h1", text: "SHOP BOT")
  end

  scenario "as an admin with invalid data" do
    sign_in_superadmin
    visit edit_machine_path(machine)
    fill_in "Name", with: ""
    click_button "Update Machine"
    expect(page).to have_css(".errors")
  end

end
