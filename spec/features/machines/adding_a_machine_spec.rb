require 'spec_helper'

feature "Adding a machine" do

  given(:machine) { FactoryBot.create(:machine, name: 'Shopbot') }

  scenario "as a visitor" do
    machine.reload
    visit new_machine_path
    expect(page.title).to match('Sign in')
  end

  scenario "as a verified user" do
    sign_in FactoryBot.create(:user, workflow_state: :verified)
    visit new_machine_path
    expect(current_path).to eq(new_machine_path)
    fill_in "Name", with: "My Machine From verified"
  end

  scenario "as a unverified user" do
    sign_in FactoryBot.create(:user, workflow_state: :unverified)
    visit new_machine_path
    expect(current_path).to eq(machines_path)
    expect(page).to have_content("verify your account")
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
