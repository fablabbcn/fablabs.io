require 'spec_helper'

feature "Adding an event" do

  scenario "as a visitor" do
    visit new_event_path
    expect(page.status_code).to eq(403)
  end

  scenario "as a user" do
    sign_in
    visit new_event_path
    expect(page.status_code).to eq(403)
  end

  scenario "as an admin" do
    lab = FactoryGirl.create(:lab)
    lab.approve!

    sign_in_superadmin
    visit new_event_path

    fill_in "Name", with: "Christmas Party"
    fill_in "Description", with: "A Party"
    select(lab.name, from: "Lab")
    click_button "Create Event"
    expect(page).to have_content("Event Created")
    expect(page).to have_title(Event.first.name)
  end

end
