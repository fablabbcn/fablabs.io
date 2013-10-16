require 'spec_helper'

describe Lab do

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:description) }
  it { should belong_to(:creator) }
  it { should validate_presence_of(:creator) }

  it "should validate uniqueness of name" do
    FactoryGirl.create(:lab, name: 'uniquename')
    expect{ FactoryGirl.create(:lab, name: 'Uniquename') }.to raise_error(ActiveRecord::RecordInvalid)
  end

  it "is unverified" do
    expect(FactoryGirl.build(:lab)).to be_unverified
  end

  it "emails creator and admins on create" do
    lab = FactoryGirl.create(:lab)
    emails = ActionMailer::Base.deliveries.map(&:to).flatten
    expect(emails - [lab.creator.email, 'john@bitsushi.com']).to be_empty
  end

  it "emails creator on approval" do
    lab = FactoryGirl.create(:lab)
    lab.approve!
    expect(last_email.to).to include(lab.creator.email)
  end

  it "makes creator admin after approval" do
    lab = FactoryGirl.create(:lab)
    expect(lab.creator).to_not have_role(:admin, lab)
    lab.approve!
    expect(lab.creator).to have_role(:admin, lab)
  end

end
