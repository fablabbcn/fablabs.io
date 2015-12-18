require 'spec_helper'

describe "Listing labs" do

  it "approved labs are on index page" do
    lab = FactoryGirl.create(:lab, workflow_state: 'approved')
    visit labs_path
    expect(page).to have_link "Fab Lab BCN"
  end

  it "unapproved labs are not on the index page" do
    lab = FactoryGirl.create(:lab)
    visit labs_path
    expect(page).to_not have_link "A Lab"
  end

end
