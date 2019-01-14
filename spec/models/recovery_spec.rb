require 'spec_helper'

describe Recovery, type: :model  do

  it { should belong_to(:user) }

  it "is valid with user" do
    user = FactoryBot.create(:user)
    expect(FactoryBot.create(:recovery, email_or_username: [user.email, user.username].sample).user ).to be_valid
  end

  it "validates user exists on create" do
    expect{FactoryBot.create(:recovery)}.to raise_error(ActiveRecord::RecordInvalid)
  end

  it "has to_param" do
    user = FactoryBot.create(:user)
    recovery = FactoryBot.create(:recovery, email_or_username: user.email)
    expect(recovery.to_param).to eq(recovery.key)
  end

  it "has find_by_key" do
    user = FactoryBot.create(:user)
    recovery = FactoryBot.create(:recovery, email_or_username: user.email)
    expect(Recovery.find_by(key: recovery.key).user).to eq(recovery.user)
  end

  it "associates user before_create" do
    user = FactoryBot.create(:user)
    expect( FactoryBot.create(:recovery, email_or_username: [user.email, user.username].sample).user ).to eq(user)
  end

  it "generates key on creation" do
    expect(FactoryBot.create(:recovery, email_or_username: FactoryBot.create(:user).email ).key).to be_present
  end

  it "uses key as to_param" do
    recovery = FactoryBot.build(:recovery)
    expect(recovery.to_param).to eq(recovery.key)
  end

end
