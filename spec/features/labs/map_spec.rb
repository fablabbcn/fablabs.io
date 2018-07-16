require 'spec_helper'

describe "map" do

  it "has map page" do
    visit labs_path
    click_link "Map view"
    expect(page).to have_title("Map")
    expect(current_url).to include(map_labs_url)
  end

  skip "shows approved labs", js: true do
    lab = FactoryGirl.create(:lab)
    lab.approve!
    visit labs_path
    click_link "Map view"
    expect(page).to have_css('.leaflet-marker-icon')
  end

  skip "doesn't show unapproved labs", js: true do
    FactoryGirl.create(:lab)
    visit map_labs_path
    expect(page).to_not have_css('.leaflet-marker-icon')
  end

end
