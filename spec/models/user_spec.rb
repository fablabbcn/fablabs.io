require 'spec_helper'

describe User do

  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password) }
  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:last_name) }
  it { should have_many(:created_labs) }

  it "should be validate uniqueness of email " do
    # http://stackoverflow.com/questions/17635189
    FactoryGirl.create(:user, email: 'john@bitsushi.com')
    expect{FactoryGirl.create(:user, email: 'john@bitsushi.com')}.to raise_error(ActiveRecord::RecordInvalid)
  end

  it "should be unverified" do
    expect(FactoryGirl.build(:user)).to be_unverified
  end

end
