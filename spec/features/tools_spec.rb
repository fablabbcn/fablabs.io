require 'spec_helper'

describe Tool do

  let(:tool) { FactoryGirl.create(:tool, name: 'Shopbot') }

  it "has index" do
    tool.reload
    visit tools_path
    expect(page).to have_title('Tools')
    expect(page).to have_link('Shopbot')
  end

  it "has show page" do
    visit tool_path(tool)
    expect(page).to have_title(tool.name)
    expect(page).to have_css('h1', text: tool.name)
  end

  it "can create tool" do
    user = FactoryGirl.create(:user)
    lab = FactoryGirl.create(:lab, creator: user)
    user.verify!
    lab.approve!
    signin user
    visit lab_path(lab)
    click_link("edit-tools")
    click_link("New Tool")
    # fill_in "Brand", with: "Makerbot Industries"
    fill_in "Name", with: "Replicator 2"
    fill_in "Description", with: "3D Printer"
    # check "3D Printing"
    click_button "Create Tool"
    expect(page).to have_css("h1", text: "Replicator 2")
  end

  it "can edit tool" do
    user = FactoryGirl.create(:user)
    user.verify!
    signin user
    visit tool_path(tool)
    click_link "Edit"
    fill_in "Name", with: "SHOP BOT"
    click_button "Update Tool"
    expect(page).to have_css("h1", text: "SHOP BOT")
  end

end
