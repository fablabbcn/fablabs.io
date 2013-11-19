require 'spec_helper'

describe 'static' do

  pending "homepage" do

    it "shows around the world button if country has no labs" do
      current_country = 'fr'
      visit root_path
      expect(page).to have_link("Around the World")
    end

    it "does not show unverified labs" do
      FactoryGirl.create(:lab, name: 'unverified', country_code: ENV['COUNTRY_CODE'])
      visit root_path
      expect(page).to_not have_link('unverified')
    end

    it "shows verified labs" do
      lab = FactoryGirl.create(:lab, name: 'verified', country_code: ENV['COUNTRY_CODE'])
      lab.approve!
      visit root_path
      expect(page).to have_link('verified')
    end

    it "doesn't show verified labs from other country" do
      lab = FactoryGirl.create(:lab, name: 'verified', country_code: 'za')
      lab.approve!
      visit root_path
      expect(page).to_not have_link('verified')
    end
  end

  pending "unauthenticated users" do
    it "has homepage" do
      lab = FactoryGirl.create(:lab, name: 'verified', country_code: ENV['COUNTRY_CODE'])
      lab.approve!
      visit root_path
      expect(page).to have_content "Fab Labs in #{Country[ENV['COUNTRY_CODE']]}"
    end
  end

  pending "authenticated users" do
    it "redirects to labs index as homepage" do
      signin FactoryGirl.create(:user)
      visit root_path
      expect(current_url).to include(labs_url)
    end
  end

  describe "all users" do
    it "has about page" do
      visit about_path
      expect(page).to have_title("About")
    end

  end

end
