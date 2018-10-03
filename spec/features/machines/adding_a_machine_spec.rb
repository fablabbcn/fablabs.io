require 'spec_helper'

feature "Adding a machine" do

  given(:machine) { FactoryBot.create(:machine, name: 'Shopbot') }

  scenario "as a visitor" do
    machine.reload
    visit new_machine_path
    expect(page.title).to match('Sign in')
  end

  %w(unverified verified).each do |state|
    scenario "as a #{state} user" do
      sign_in FactoryBot.create(:user, workflow_state: state)
      visit machines_path
      visit new_machine_path
    end
  end

  scenario "as an admin" do
    sign_in_superadmin
    visit machines_path
    click_link "New Machine"
    fill_in "Name", with: "Replicator 2"
    fill_in "Description", with: "3D Printer"
    click_button "New Machine"
    expect(page).to have_css("h1", text: "Replicator 2")
  end

end
