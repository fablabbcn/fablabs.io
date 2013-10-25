require 'spec_helper'

describe Lab do

  pending "MOAR TESTS"

  %w(name description address_1 country_code creator).each do |requirement|
    it { should validate_presence_of(requirement) }
  end
  it { should belong_to(:creator) }

  it "has country method" do
    lab = FactoryGirl.build_stubbed(:lab, country_code: 'FR')
    lab.country.name.should eq('France')
  end

  describe "avatar" do

    it "has default avatar" do
      user = FactoryGirl.build_stubbed(:user)
      user.avatar.should include('default-user-avatar.png')
    end

    it "has custom avatar" do
      user = FactoryGirl.build_stubbed(:user, avatar_src: 'http://i.imgur.com/XYBgt.gif')
      user.avatar.should eq('http://i.imgur.com/XYBgt.gif')
    end

  end

  it "validates uniqueness of name" do
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
