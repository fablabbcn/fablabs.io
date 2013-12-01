require 'spec_helper'

describe Employee do

  let(:lab) { FactoryGirl.create(:lab, workflow_state: 'approved') }
  let(:user) { FactoryGirl.create(:user, first_name: "Homer", last_name: "Simpson") }
  let(:employee) { FactoryGirl.create(:employee, user: user, lab: lab, job_title: "Nuclear Safety Inspector") }

  describe :unauthenticated do
    it "cannot apply" do
      visit lab_url(lab)
      expect(page).to_not have_link("I work here")
    end

    it "doesn't list unverified employees of a lab" do
      employee.reload
      visit lab_url(lab)
      expect(page).to_not have_link("Homer Simpson")
    end

    it "lists approved employees of a lab" do
      employee.approve!
      visit lab_url(lab)
      expect(page).to have_link("Homer Simpson")
    end

  end

  describe :user do

    it "cannot apply if unverified" do
      signin user
      visit lab_url(lab)
      expect(page).to_not have_link("I work here")
    end

    it "can apply if verified" do
      user.verify!
      signin user
      visit lab_url(lab)
      click_link "I work here"
      fill_in "Job title", with: "King"
      fill_in "Description", with: "I sit on a throne"
      click_button "Send Application"
      expect(page).to have_content("Thank you for applying")
      # expect(last_email.to).to include(lab.admin.email)
    end

    it "shows applied if applied" do
      employee.reload
      signin user
      visit lab_url(lab)
      expect(page).to have_content("Applied")
      expect(page).to_not have_content("Nuclear Safety Inspector")
    end

    it "shows employee if approved" do
      employee.approve!
      signin user
      visit lab_url(lab)
      expect(page).to_not have_content("Applied")
      expect(page).to have_link("Homer Simpson")
      expect(page).to have_content("Nuclear Safety Inspector")
    end

  end

  describe :lab_admin do

    it "can approve employee" do
      admin = FactoryGirl.create(:user)
      admin.add_role :admin, lab
      admin.verify!
      employee.reload
      signin admin
      visit lab_path(lab)
      expect(page).to_not have_link("Homer Simpson")

      click_link "edit-employees"
      expect(page).to have_content "Homer Simpson"
      click_button "Approve"
      expect(current_path).to include(lab_path(lab))
      expect(page).to have_content("Nuclear Safety Inspector")
      expect(page).to have_link("Homer Simpson")

      expect(last_email.to).to include(user.email)
    end

    it "can remove employee"
    it "can edit employee"

  end

end
