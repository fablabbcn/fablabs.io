require 'spec_helper'

describe Lab do

  describe "all users" do

    it "index is homepage" do
      visit root_path
      expect(page).to have_content "Labs"
    end

    it "has map" do
      visit labs_path
      click_link "Map"
      page.should have_title "Map"
    end

    it "approved labs are on index page" do
      FactoryGirl.create(:lab, name: 'A Lab', workflow_state: 'approved')
      visit labs_path
      expect(page).to have_link "A Lab"
    end

    it "unapproved labs are not on the index page" do
      FactoryGirl.create(:lab, name: 'A Lab')
      visit labs_path
      expect(page).to_not have_link "A Lab"
    end

    it "approved labs have show page" do
      lab = FactoryGirl.create(:lab, name: 'A Lab', workflow_state: 'approved')
      visit lab_path(lab)
      expect(page).to have_title 'A Lab'
    end

    it "unapproved labs don't have show page" do
      lab = FactoryGirl.create(:lab, name: 'A Lab')
      visit lab_path(lab)
      expect(page).to have_content 'Access Denied'
    end

  end

  describe "unauthenticated user" do
    it "cannot create lab" do
      visit new_lab_path
      expect(current_path).to eq(signin_path)
    end
  end

  describe "unverified user" do
    it "cannot create lab" do
      signin FactoryGirl.create(:user)
      visit new_lab_path
      expect(page).to have_content("Please verify your email")
      expect(current_path).to eq(root_path)
    end
  end

  describe "authenticated user" do

    let(:user) { FactoryGirl.create(:user) }

    it "can delete lab" do
      user.add_role :admin
      signin user
      lab = FactoryGirl.create(:lab, name: 'A Lab', workflow_state: 'approved')
      visit lab_path(lab)
      click_link "Delete Lab"
      expect(page).to have_content "deleted"
    end

    it "can create lab" do
      signin user
      visit new_lab_path
      fill_in 'Name', with: 'New Lab'
      fill_in 'Description', with: 'An awesome place'
      fill_in 'lab_address_1', with: 'Mars'
      select 'United Kingdom', from: 'Country'
      click_button 'Add Lab'
      expect(page).to have_content "Thanks"
    end

    it "requires valid form to create lab" do
      signin user
      visit new_lab_path
      click_button 'Add Lab'
      expect(page).to have_css ".errors"
    end

    it "can edit lab" do
      lab = FactoryGirl.create(:lab, creator: user)
      lab.approve!
      signin user
      visit lab_path(lab)
      click_link "Edit Lab"
      fill_in "Name", with: 'New Name'
      click_button 'Update Lab'
      page.should have_content("Lab was successfully updated")
    end

  end

end
