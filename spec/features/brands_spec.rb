require 'spec_helper'

describe Brand do

  let(:brand) { FactoryGirl.create(:brand, name: 'Makerbot Industries') }

  describe :unauthenticated do
    it "cannot create brand" do
      visit new_brand_path
      expect(page.status_code).to eq(403)
    end

  end

  describe :user do
    it "cannot create brand" do
      user = FactoryGirl.create(:user)
      user.verify!
      signin user
      visit new_brand_path
      expect(page.status_code).to eq(403)
    end

  end

  describe :admin do
    it "can create brand" do
      user = FactoryGirl.create(:user)
      user.verify!
      user.add_role :admin
      signin user
      visit new_brand_path
      fill_in "Name", with: "Roland"
      click_button "Create Brand"
      expect(page).to have_content("Brand Created")
    end

  end

end