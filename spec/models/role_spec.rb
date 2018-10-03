require 'spec_helper'

describe Role, type: :model  do

  skip "doesn't allow :superadmin" do
    user = FactoryBot.create(:user)
    lab = FactoryBot.create(:lab)
    user.add_role :superadmin
    user.add_role :superadmin, lab
    expect(user.roles).to be_empty
    expect(Role.all).to be_empty
  end

  it "allows :admin" do
    user = FactoryBot.create(:user)
    user.add_role :superadmin
    expect(user.roles).to_not be_empty
    expect(Role.all).to_not be_empty
  end

end
