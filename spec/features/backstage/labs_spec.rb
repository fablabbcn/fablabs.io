require 'spec_helper'

describe Lab do
  it "has root page" do
    signin FactoryGirl.create(:user)
    visit backstage_root_path
    page.should have_title('Labs')
  end
end
