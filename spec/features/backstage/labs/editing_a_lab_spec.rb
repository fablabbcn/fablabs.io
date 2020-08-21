require 'spec_helper'

feature "Editing a lab" do

  let(:lab) { FactoryBot.create(:lab, name: "iaac") }

  scenario "as a visitor" do
    visit edit_backstage_lab_path(lab)
    expect(page.title).to match('Sign in')
  end

  scenario "as a user" do
    sign_in
    visit edit_backstage_lab_path(lab)
    expect(current_path).to eq(root_path)
  end

  scenario "as an admin" do
    lab.reload
    sign_in_superadmin
    visit backstage_labs_path
    click_link "iaac"
    click_link "Edit Lab"
    fill_in "lab_name", with: "Valldaura"
    select 'Iceland', from: "lab_country_code"
    click_on "Save", match: :first
    expect(page).to have_content("Lab updated")
    expect(page).to have_content("Valldaura")
  end

  scenario "as an admin with invalid details" do
    sign_in_superadmin
    visit edit_backstage_lab_path(lab)
    fill_in "lab_name", with: ""
    click_on "Save", match: :first
    expect(page).to have_css(".errors")
  end

end
