require 'spec_helper'

feature "Editing a machine" do

  let(:machine) { FactoryBot.create(:machine) }

  scenario "as a visitor" do
    visit machine_path(machine)
    expect(page).to_not have_link("Edit Machine")
    visit edit_machine_path(machine)
    expect(page.title).to match('Sign in')
  end

  %w(unverified verified).each do |state|
    scenario "as a #{state} user" do
      sign_in FactoryBot.create(:user, workflow_state: state)
      visit machine_path(machine)
      visit edit_machine_path(machine)
    end
  end

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
