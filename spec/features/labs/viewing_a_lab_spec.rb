require 'spec_helper'

describe "Viewing a lab" do

  it "approved labs have show page" do
    lab = FactoryGirl.create(:lab, name: 'A Lab', workflow_state: 'approved')
    visit lab_path(lab)
    expect(page).to have_title 'A Lab'
  end

  it "unapproved labs don't have show page" do
    lab = FactoryGirl.create(:lab, name: 'A Lab')
    # expect{visit lab_path(lab)}.to raise_error ActiveRecord::RecordNotFound
    visit lab_path(lab)
    expect(page).to have_content("not found")
  end

end
