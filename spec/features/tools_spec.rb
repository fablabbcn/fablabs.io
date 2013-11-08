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

end
