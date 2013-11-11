require 'spec_helper'

describe Lab do

  before(:each) do
    user = FactoryGirl.create(:user)
    user.add_role :admin
    signin user
  end

  it "has root page" do
    visit backstage_root_path
    expect(page).to have_title('Labs')
  end

  it "has show page" do
    lab = FactoryGirl.create(:lab)
    visit backstage_lab_path(lab)
    expect(page).to have_title(lab.name)
  end

  it "can approve lab" do
    lab = FactoryGirl.create(:lab)
    visit backstage_lab_path(lab)
    click_button "Approve Lab"
    expect(page).to have_content("Lab approved")
  end

end
