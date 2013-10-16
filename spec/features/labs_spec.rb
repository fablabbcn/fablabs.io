require 'spec_helper'

describe Lab do

  describe "all users" do

    it "index is homepage" do
      visit root_path
      page.should have_content "Labs"
    end

    it "can view labs index" do
      FactoryGirl.create(:lab, name: 'A Lab')
      visit labs_path
      page.should have_link "A Lab"
    end

    it "has show page" do
      lab = FactoryGirl.create(:lab, name: 'A Lab')
      visit lab_path(lab)
      page.should have_title 'A Lab'
    end

  end

  describe "UNauthenticated user" do

    it "cannot create lab" do
      visit new_lab_path
      current_path.should eq(signin_path)
    end

  end

  describe "authenticated user" do

    it "can delete lab" do
      signin FactoryGirl.create(:user)
      lab = FactoryGirl.create(:lab, name: 'A Lab')
      visit lab_path(lab)
      click_link "Delete Lab"
      page.should have_content "deleted"
    end

    it "can create lab" do
      signin FactoryGirl.create(:user)
      visit new_lab_path
      fill_in 'Name', with: 'New Lab'
      fill_in 'Description', with: 'An awesome place'
      click_button 'Add Lab'
      page.should have_content "Thanks"
    end

  end

end
