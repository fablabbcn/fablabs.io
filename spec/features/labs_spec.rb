require 'spec_helper'

describe Lab do

  describe "all users" do

    it "index is homepage" do
      visit root_path
      expect(page).to have_content "Labs"
    end

    describe "map" do

      it "has map page" do
        visit labs_path
        click_link "Map"
        expect(page).to have_title("Map")
        expect(current_url).to include(map_labs_url)
      end

      pending "shows approved labs", js: true do
        lab = FactoryGirl.create(:lab)
        lab.approve!
        visit labs_path
        click_link "Map"
        expect(page).to have_css('.leaflet-marker-icon')
      end

      pending "doesn't show unapproved labs", js: true do
        FactoryGirl.create(:lab)
        visit map_labs_path
        expect(page).to_not have_css('.leaflet-marker-icon')
      end

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
      expect{visit lab_path(lab)}.to raise_error ActiveRecord::RecordNotFound
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
      expect(page).to have_content("Access Denied")
      # expect(current_path).to eq(root_path)
    end
  end

  describe "authenticated user" do

    let(:user) { FactoryGirl.create(:user) }

    it "can delete lab" do
      user.verify!
      user.add_role :admin
      signin user
      lab = FactoryGirl.create(:lab, name: 'A Lab', workflow_state: 'approved')
      visit lab_path(lab)
      click_link "Delete Lab"
      expect(page).to have_content "deleted"
    end

    it "can create lab" do
      user.verify!
      signin user
      visit new_lab_path
      fill_in 'Name', with: 'New Lab'
      fill_in 'Description', with: 'An awesome place'
      fill_in 'lab_address_1', with: 'Mars'
      fill_in 'lab_links_attributes_0_url', with: 'http://www.newlab.com'
      select 'United Kingdom', from: 'Country'
      fill_in 'Slug', with: 'newlab'
      click_button 'Add Lab'
      expect(page).to have_content "Thanks"
    end

    it "requires valid form to create lab" do
      user.verify!
      signin user
      visit new_lab_path
      click_button 'Add Lab'
      expect(page).to have_css ".errors"
    end

    it "can edit lab" do
      user.verify!
      lab = FactoryGirl.create(:lab, creator: user)
      lab.approve!
      signin user
      visit lab_path(lab)
      click_link "Edit Lab"
      fill_in "Name", with: 'New Name'
      click_button 'Update Lab'
      expect(page).to have_content("Lab was successfully updated")
    end

  end

  pending "managing admins" do
    let(:admin) { FactoryGirl.create(:user) }
    let(:lab) { FactoryGirl.create(:lab, creator: admin) }
    let(:user) { FactoryGirl.create(:user) }

    # it "can add an admin" do
    #   lab.approve!
    #   signin admin
    #   visit lab_path(lab)
    #   click_link "Manage Admins"
    #   click_button "Update"
    #   expect(page).to have_content("Admins updated")
    # end

    it "can apply to become admin" do
      signin user
      visit lab_path(lab)
      click_link "Apply to become an admin"
      fill_in "Description", with: "I work here"
      click_button "Submit"
      expect(page).to have_content("Application submitted")
    end

    it "admin doesn't need to apply to become admin" do
      signin admin
      visit lab_path(lab)
      expect(page).to_not have_link("Apply to become an admin")
    end

  end

end
