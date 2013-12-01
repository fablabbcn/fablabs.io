require 'spec_helper'

describe Discussion do

  pending "can be created" do
    tool = FactoryGirl.create(:tool)
    signin FactoryGirl.create(:user)
    visit tool_path(tool)
    click_link "Start a new Discussion"
    fill_in "Title", with: "Should I get this?"
    fill_in "Body", with: "I dunno?"
    click_button "Create Discussion"
    expect(page).to have_content("Discussion Created")
  end

end
