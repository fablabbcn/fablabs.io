require 'spec_helper'

describe "map" do

  it "can load mapdata.json without errors" do

    # TODO: use Factorybot to create this lab object
    # It does not catch the error if map_serializer is like it was before 5f409af
    # lab = Factorybot.create(:lab)
    # Which resulted in the map to show up empty
    Lab.create!(
      name: "MyLab",
      kind: 'fab_lab',
      country_code: 'IS',
      address_1: 'MyStreet 24',
      email: 'none@example.com',
      description: 'boh',
      blurb: 'thanks',
      phone: '+39323424324',
      network: true,
      tools: true,
      programs: true,
      activity_status: 'active',
      workflow_state: 'approved',
      latitude: 64.963,
      longitude: 19.0208
    )

    visit mapdata_labs_url
    expect(page).to have_http_status(200)
  end

  it "has map page" do
    visit labs_path
    click_link "Map view"
    expect(page).to have_title("Map")
    expect(current_url).to include(map_labs_url)
  end

  skip "shows approved labs", js: true do
    lab = FactoryBot.create(:lab)
    lab.approve!
    visit labs_path
    click_link "Map view"
    expect(page).to have_css('.leaflet-marker-icon')
  end

  skip "doesn't show unapproved labs", js: true do
    FactoryBot.create(:lab)
    visit map_labs_path
    expect(page).to_not have_css('.leaflet-marker-icon')
  end

end
