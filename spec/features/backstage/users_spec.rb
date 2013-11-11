require 'spec_helper'

describe User do

  before(:each) do
    user = FactoryGirl.create(:user)
    user.add_role :admin
    signin user
  end

  it "has root page" do
    visit backstage_users_path
    expect(page).to have_title('Users')
  end

  it "has show page" do
    user = FactoryGirl.create(:user)
    visit backstage_user_path(user)
    expect(page).to have_title(user.full_name)
  end

end
