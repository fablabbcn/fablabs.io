require 'spec_helper'

feature "Viewing a machine" do

  given(:machine) { FactoryGirl.create(:machine) }

  scenario "as a visitor" do
    visit machine_path(machine)
    find('H1').should have_content(machine)
  end

  scenario "as a user" do
    sign_in
    visit machine_path(machine)
    find('H1').should have_content(machine)
  end

  scenario "as an admin" do
    sign_in_superadmin
    visit machine_path(machine)
    find('H1').should have_content(machine.name)
  end

end
