require 'spec_helper'

describe User do

  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password) }
  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:last_name) }
  it { should have_many(:created_labs) }
  it { should have_many(:recoveries) }
  it { should have_many(:role_applications) }
  it { should have_many(:employees) }
  it { should have_many(:comments) }

  it "has initial state" do
    expect(FactoryGirl.build(:user).current_state).to eq('unverified')
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

  it "should not be admin" do
    expect(FactoryGirl.build_stubbed(:user)).to_not be_admin
  end

  it "should downcase email before creation" do
    expect(FactoryGirl.create(:user, email: "UPPER@CASE.com").email).to eq("upper@case.com")
  end

  it "has full_name" do
    user = FactoryGirl.build_stubbed(:user, first_name: "Homer", last_name: "Simpson")
    expect(user.full_name).to eq("Homer Simpson")
    expect(user.to_s).to eq("Homer Simpson")
  end

  it "validates uniqueness of email " do
    # http://stackoverflow.com/questions/17635189
    FactoryGirl.create(:user, email: 'john@bitsushi.com')
    expect{FactoryGirl.create(:user, email: 'JOHN@bitsushi.com')}.to raise_error(ActiveRecord::RecordInvalid)
  end

  it "is unverified" do
    expect(FactoryGirl.build(:user)).to be_unverified
  end

  it "sends welcome email" do
    user = FactoryGirl.create(:user)
    expect(last_email.to).to include(user.email)
  end

  it "has default locale" do
    expect(FactoryGirl.build_stubbed(:user).locale).to eq(I18n.default_locale)
  end

  it "has custom locale" do
    expect(FactoryGirl.build_stubbed(:user, my_locale: 'fr').locale).to eq('fr')
  end

end
