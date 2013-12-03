require 'spec_helper'

feature "Listing machines" do

  given!(:machine) { FactoryGirl.create(:machine, name: "Shopbot") }

  scenario "as a visitor" do
    visit machines_path
    expect(page).to have_title('Machines')
    expect(page).to have_link('Shopbot')
  end

  scenario "as a user" do
    sign_in
    visit machines_path
    expect(page).to have_title('Machines')
    expect(page).to have_link('Shopbot')
  end

  scenario "as an admin" do
    sign_in_superadmin
    machine.reload
    visit machines_path
    expect(page).to have_title('Machines')
    expect(page).to have_link('Shopbot')
  end

end
