require 'spec_helper'

describe Employee do

  it "is shown on lab page" do
    user = FactoryGirl.create(:user, first_name: "Cookie", last_name: "Monster")
    employee = FactoryGirl.create(:employee, job_title: "King of Cookies", user: user)
    employee.lab.approve!
    visit lab_path(employee.lab)
    expect(page).to have_content("King of Cookies")
    expect(page).to have_link("Cookie Monster")
  end

  it "has initial state" do
    expect(FactoryGirl.build(:employee).current_state).to eq('unverified')
  end

  it "can apply to be recognised as an employee" do
    lab = FactoryGirl.create(:lab)
    signin FactoryGirl.create(:user)
    lab.approve!
    visit lab_url(lab)
    click_link "I work here"
    fill_in "Job title", with: "King"
    fill_in "Description", with: "I sit on a throne"
    click_button "Send Application"
    page.should have_content("Thank you for applying")
  end

end
