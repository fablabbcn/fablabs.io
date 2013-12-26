require 'spec_helper'

feature "Listing events" do

  given!(:past_event) { FactoryGirl.create(:event, starts_at: Time.zone.now - 1.week ) }
  given!(:future_event) { FactoryGirl.create(:event, starts_at: Time.zone.now + 1.week ) }

  scenario "future events are on index page" do
    sign_in_superadmin
    visit events_path
    expect(page).to have_link future_event
  end

  scenario "past events are not on index page" do
    sign_in_superadmin
    visit events_path
    expect(page).to_not have_link past_event
  end

end

