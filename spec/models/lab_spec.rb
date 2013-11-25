require 'spec_helper'

describe Lab do

  pending "MOAR TESTS"
  it { should have_many(:role_applications) }
  it { should have_many(:links) }
  it { should have_many(:facilities) }
  it { should have_many(:discussions) }
  # it { should have_many(:tools).through(:facilities) }
  pending "validates uniqueness of slug"
  it "cannot use slug with reserved name" do
    %w(labs users).each do |word|
      expect{FactoryGirl.create(:lab, slug: word)}.to raise_error(ActiveRecord::RecordInvalid)
    end
  end
  it { should have_many(:employees) }

  it "downcases email before creation" do
    expect(FactoryGirl.create(:lab, email: "UPPER@CASE.com").email).to eq("upper@case.com")
  end

  it "disallows invalid email" do
    ['invalid', 'not an email'].each do |email|
      expect{FactoryGirl.create(:lab, email: email)}.to raise_error(ActiveRecord::RecordInvalid)
    end
  end

  %w(name description address_1 country_code creator).each do |requirement|
    it { should validate_presence_of(requirement) }
  end
  it { should belong_to(:creator) }

  it "has localised country method" do
    lab = FactoryGirl.build_stubbed(:lab, country_code: 'FR')
    I18n.locale = 'en'
    expect(lab.country.name).to eq('France')
    I18n.locale = 'es'
    expect(lab.country.name).to eq('Francia')
  end

  it "has short_address" do
    lab = FactoryGirl.build_stubbed(:lab, city: 'London', country_code: 'gb')
    expect(lab.short_address).to eq("London, #{lab.country}")
  end

  describe "avatar" do

    it "has default avatar" do
      user = FactoryGirl.build_stubbed(:user)
      user.avatar.should include('default-user-avatar')
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

  pending "makes creator admin after approval" do
    lab = FactoryGirl.create(:lab)
    expect(lab.creator).to_not have_role(:admin, lab)
    lab.approve!
    expect(lab.creator).to have_role(:admin, lab)
  end

  it "has many tools/facilities" do
    lab = FactoryGirl.create(:lab)
    tool = FactoryGirl.create(:tool)
    lab.tools << tool
    expect(lab.tools).to include(tool)
    expect(lab.facilities).to include(tool.facilities.first)
    expect(tool.labs).to include(lab)
  end

end
