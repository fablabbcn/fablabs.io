require 'spec_helper'

describe "Visitor homepage" do

  it "has homepage" do
    lab = FactoryGirl.create(:lab, name: 'verified', country_code: 'gb')
    lab.approve!
    visit root_path
    expect(page).to have_content "Fab Labs in #{Country['gb']}"
  end

  pending "shows around the world button if country has no labs" do
    current_country = 'fr'
    visit root_path
    expect(page).to have_link("Around the World")
  end

  pending "does not show unverified labs" do
    FactoryGirl.create(:lab, name: 'unverified')
    visit root_path
    expect(page).to_not have_link('unverified')
  end

  pending "shows verified labs" do
    lab = FactoryGirl.create(:lab, name: 'verified')
    lab.approve!
    visit root_path
    expect(page).to have_link('verified')
  end

  pending "doesn't show verified labs from other country" do
    lab = FactoryGirl.create(:lab, name: 'verified', country_code: 'za')
    lab.approve!
    visit root_path
    expect(page).to_not have_link('verified')
  end

end
