require 'spec_helper'

describe "User homepage" do

  it "has homepage" do
    lab = FactoryBot.create(:lab, name: 'verified', country_code: 'gb', workflow_state: 'approved')
    visit root_path
    expect(page).to have_content "Register your lab"
  end

end
