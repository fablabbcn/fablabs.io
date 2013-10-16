require 'spec_helper'

describe Lab do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:description) }
  it { should belong_to(:creator) }

  it "should be unverified" do
    expect(FactoryGirl.build(:lab)).to be_unverified
  end
end
