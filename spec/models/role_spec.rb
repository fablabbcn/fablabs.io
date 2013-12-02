require 'spec_helper'

describe Role do

  pending "doesn't allow :superadmin" do
    user = FactoryGirl.create(:user)
    lab = FactoryGirl.create(:lab)
    user.add_role :superadmin
    user.add_role :superadmin, lab
    expect(user.roles).to be_empty
    expect(Role.all).to be_empty
  end

  it "allows :admin" do
    user = FactoryGirl.create(:user)
    user.add_role :admin
    expect(user.roles).to_not be_empty
    expect(Role.all).to_not be_empty
  end

end
