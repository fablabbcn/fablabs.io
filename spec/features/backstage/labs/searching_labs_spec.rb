require 'spec_helper'

feature "Searching labs" do

  let(:lab) { FactoryBot.create(:lab, name: "iaac") }
  class Capybara::Session
    def submit_form(element)
      Capybara::RackTest::Form.new(driver, element.native).submit({})
    end
  end

  scenario "as a visitor" do
    visit backstage_labs_path
    expect(page.title).to match('Sign in')
  end

  scenario "as a user" do
    sign_in
    visit backstage_labs_path
    expect(current_path).to eq(root_path)
  end

  # scenario "as an admin" do
  #   lab.reload
  #   sign_in_superadmin
  #   visit backstage_labs_path
  #   expect(page.title).to match("Labs")
  #   fill_in 'q_name_or_city_cont', with: 'iaac' #
  #   form = find '.lab_search'
  #   # expect(form)
  #   page.submit_form form
  #   expect(page).to have_link("iaac")
  # end

end