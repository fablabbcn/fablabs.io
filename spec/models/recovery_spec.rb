require 'spec_helper'

describe Recovery do

  it { should belong_to(:user) }

  it "validates user exists on create" do
    expect{FactoryGirl.create(:recovery)}.to raise_error(ActiveRecord::RecordInvalid)
  end

  it "associates user" do
    user = FactoryGirl.create(:user)
    expect( FactoryGirl.create(:recovery, email: user.email).user ).to eq(user)
  end

  it "generates key on creation" do
    expect(FactoryGirl.create(:recovery, email: FactoryGirl.create(:user).email).key).to be_present
  end

  it "emails user after create" do
    recovery = FactoryGirl.create(:recovery, email: FactoryGirl.create(:user).email)
    expect(last_email.to).to include(recovery.user.email)
  end

  it "uses key as to_param" do
    recovery = FactoryGirl.build(:recovery)
    expect(recovery.to_param).to eq(recovery.key)
  end

end
