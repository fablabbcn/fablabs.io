require 'spec_helper'

describe Lab do

  before(:each) do
    user = FactoryGirl.create(:user)
    user.add_role :admin
    signin user
  end

  it "has root page" do
    visit backstage_root_path
    page.should have_title('Labs')
  end

  it "has show page" do
    lab = FactoryGirl.create(:lab)
    visit backstage_lab_path(lab)
    page.should have_title(lab.name)
  end

  it "can approve lab" do
    lab = FactoryGirl.create(:lab)
    visit backstage_lab_path(lab)
    click_button "Approve Lab"
    page.should have_content("Lab approved")
  end

end
