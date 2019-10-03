require 'spec_helper'

feature "Adding a lab" do

  scenario "as a visitor" do
    visit new_lab_path
    expect(page.title).to match('Sign in')
  end

  scenario "as an unverified user" do
    sign_in
    visit new_lab_path
    # expect(page.status_code).to eq(403)
  end

  feature "as a verified user" do
    Capybara.javascript_driver = :webkit
    given(:user) { FactoryBot.create(:user, email: "creator@fablabfoundation.com") }
    let!(:as220) { FactoryBot.create(:lab, name: "AS220 Labs", slug: "as220labs", workflow_state: :approved, is_referee: true) }
    let!(:bcn) { FactoryBot.create(:lab, name: "Fab Lab BCN", slug: "fablabbcn", workflow_state: :approved, is_referee: true) }
    let!(:cascina) { FactoryBot.create(:lab, name: "Fab Lab Cascina", slug: "fablabcascina", workflow_state: :approved, is_referee: true) }
    let!(:admin) { FactoryBot.create(:user, email: "admin@fablabfoundation.com") }
    let!(:referee_one) { FactoryBot.create(:user, email:"referee@as220.org", first_name: "Referee", last_name: "AS220") }
    let!(:referee_two) { FactoryBot.create(:user, email:"referee@fablabbcn.org", first_name: "Referee", last_name: "BCN") }
    let!(:referee_three) { FactoryBot.create(:user, email:"referee@fablabcascina.org", first_name: "Referee", last_name: "Cascina") }

    background do
      admin.add_role :superadmin

      referee_one.verify!
      referee_one.add_role :admin, as220

      referee_two.verify!
      referee_two.add_role :admin, bcn

      referee_three.verify!
      referee_three.add_role :admin, cascina

      user.verify!
      sign_in user

      visit labs_path
      click_link "Add Lab"
    end

    scenario "as a user with valid details" do
      choose "lab_kind_mini_fab_lab"
      choose "lab_tools_1"
      choose "lab_network_1"
      choose "lab_programs_1"
      choose "lab_charter_1"
      choose "lab_public_1"
      select 'as220labs', from: 'Referees'
      select 'fablabbcn', from: 'Referees'
      select 'fablabcascina', from: 'Referees'
      fill_in 'lab_name', with: 'New Lab'
      fill_in 'lab_email', with: 'lab@fablabs.org'
      fill_in 'lab_blurb', with: 'Some blurb'
      fill_in 'lab_phone', with: '+39-39333333'
      fill_in 'lab_description', with: 'An awesome place'
      fill_in 'lab_address_1', with: 'Mars'
      fill_in 'lab_links_attributes_0_url', with: 'http://www.newlab.com'
      fill_in 'lab_employees_attributes_0_job_title', with: 'Spaceman'
      fill_in 'lab_employees_attributes_0_description', with: 'I explore the surface'
      fill_in 'County', with: 'County'
      select 'United Kingdom', from: 'Country'
      fill_in 'Slug', with: 'newlab'
      click_button 'Add Lab'
      expect(page).to have_content "Thanks"
      lab = Lab.last
      expect(lab.referee_approval_processes.count).to eq(3)
      emails = ActionMailer::Base.deliveries
      expect(emails.count).to eq(5)
    end

    scenario "as a user with invalid details" do
      fill_in 'lab_name', with: 'No details'
      click_button 'Add Lab'
      expect(page).to have_css ".errors"
    end

  end

end
