require 'spec_helper'

describe User do

  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password) }
  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:last_name) }
  it { should have_many(:created_labs) }

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

end
