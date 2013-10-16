require 'spec_helper'

describe Lab do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:description) }
  it { should belong_to(:creator) }
  it { should validate_presence_of(:creator) }
  # it { should validate_uniqueness_of(:name) }

  it "should be unverified" do
    expect(FactoryGirl.build(:lab)).to be_unverified
  end

  it "should email creator and admins on create" do
    lab = FactoryGirl.create(:lab)
    # p ActionMailer::Base.deliveries.last.inspect
    expect(last_email.to).to include(lab.creator.email)
  end

  it "should email creator on approval" do
    lab = FactoryGirl.create(:lab)
    lab.approve!
    expect(last_email.to).to include(lab.creator.email)
  end

end
