require 'spec_helper'

describe RoleApplication do
  it { should belong_to(:lab)}
  it { should belong_to(:user)}
  it { should validate_presence_of(:user) }
  it { should validate_presence_of(:lab) }
  it { should validate_presence_of(:description) }

  it "is valid" do
    expect(FactoryBot.build(:role_application)).to be_valid
  end

end
