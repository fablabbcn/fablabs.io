require 'spec_helper'

feature "Editing a lab" do

  let(:lab) { FactoryGirl.create(:lab, name: "iaac") }

  scenario "as a visitor" do
    visit edit_backstage_lab_path(lab)
    expect(page.title).to match('Sign in')
  end

  scenario "as a user" do
    sign_in
    visit edit_backstage_lab_path(lab)
    expect(page.status_code).to eq(403)
  end

  scenario "as an admin" do
    lab.reload!
    sign_in_admin
    visit backstage_labs_path
    click_link "iaac"
    click_button "Edit Lab"
    fill_in "Name", with: "Valldaura"
    click_button "Update Lab"
    expect(page).to have_content("Lab updated")
    expect(page).to have_content("Valldaura")
  end

  scenario "as an admin with invalid details" do
    sign_in_admin
    visit edit_backstage_lab_path(lab)
    fill_in "Name", with: ""
    click_button "Update Lab"
    expect(page).to have_css(".errors")
  end

end