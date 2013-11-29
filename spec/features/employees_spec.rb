require 'spec_helper'

describe Employee do

  it "is shown on lab page when approved" do
    user = FactoryGirl.create(:user, first_name: "Cookie", last_name: "Monster")
    employee = FactoryGirl.create(:employee, job_title: "King of Cookies", user: user)
    employee.lab.approve!
    employee.approve!
    visit lab_path(employee.lab)
    expect(page).to have_content("King of Cookies")
    expect(page).to have_link("Cookie Monster")
  end

  it "is not show on lab page until approved" do
    user = FactoryGirl.create(:user, first_name: "Cookie", last_name: "Monster")
    lab = FactoryGirl.create(:lab)
    lab.approve!
    employee = FactoryGirl.create(:employee, job_title: "King of Cookies", user: user, lab: lab)
    visit lab_path(employee.lab)
    expect(page).to_not have_content("King of Cookies")
  end

  it "has initial state" do
    expect(FactoryGirl.build(:employee).current_state).to eq('unverified')
  end

  it "can apply to be recognised as an employee" do
    lab = FactoryGirl.create(:lab)
    user = FactoryGirl.create(:user)
    user.verify!
    lab.approve!
    signin user
    visit lab_url(lab)
    click_link "I work here"
    fill_in "Job title", with: "King"
    fill_in "Description", with: "I sit on a throne"
    click_button "Send Application"
    page.should have_content("Thank you for applying")
  end

  it "cannot apply if already an employee" do
    lab = FactoryGirl.create(:lab)
    lab.approve!
    user = FactoryGirl.create(:user)
    employee = FactoryGirl.create(:employee, user: user, lab: lab)
    signin user
    visit lab_url(lab)
    expect(page).to_not have_link "I work here"
    # expect(page).to have_content "You work here"
  end

  pending "can approve employee" do
    user = FactoryGirl.create(:user, first_name: "Homer", last_name: "Simpson")
    lab = FactoryGirl.create(:lab)
    FactoryGirl.create(:employee, user: user, lab: lab)
    lab.approve!
    signin lab.creator
    visit lab_path(lab)
    click_link "Employees"
    expect(page).to have_content "Homer Simpson"
    click_button "Approve"
    expect(current_path).to include(lab_path(lab))
    expect(page).to have_content "Homer Simpson"
  end

end
