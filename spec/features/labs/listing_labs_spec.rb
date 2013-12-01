require 'spec_helper'

describe "Listing labs" do

  let!(:lab) { FactoryGirl.create(:lab) }

  it "approved labs are on index page" do
    lab.approve!
    visit labs_path
    expect(page).to have_link "Fab Lab BCN"
  end

  it "unapproved labs are not on the index page" do
    visit labs_path
    expect(page).to_not have_link "A Lab"
  end

end

