require 'spec_helper'

describe "Visitor homepage" do

  it "has homepage" do
    lab = FactoryGirl.create(:lab, name: 'verified', country_code: 'gb', workflow_state: 'approved')
    visit root_path
    expect(page).to have_content "Show me Fab Labs"
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
    lab = FactoryGirl.create(:lab, name: 'verified', workflow_state: 'approved')
    visit root_path
    expect(page).to have_link('verified')
  end

  pending "doesn't show verified labs from other country" do
    lab = FactoryGirl.create(:lab, name: 'verified', country_code: 'za', workflow_state: 'approved')
    visit root_path
    expect(page).to_not have_link('verified')
  end

end
