require 'spec_helper'

describe Brand do

  let(:brand) { FactoryGirl.create(:brand, name: 'Makerbot Industries') }

  it "can create brand" do
    user = FactoryGirl.create(:user)
    user.verify!
    signin user
    visit new_brand_path
    fill_in "Name", with: "Roland"
    click_button "Create Brand"
    expect(page).to have_content("Brand Created")
  end

end