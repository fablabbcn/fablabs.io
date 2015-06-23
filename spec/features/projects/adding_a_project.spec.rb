require 'spec_helper'

feature "Adding a project" do

  scenario "as a visitor" do
    visit new_project_path
    expect(page.title).to match('Sign in')
  end

  scenario "as an unverified user" do
    sign_in
    visit new_project_path
    # expect(page.status_code).to eq(403)
  end
end
