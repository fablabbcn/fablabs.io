require 'spec_helper'

describe Recovery do
  it { should belong_to(:user) }


  it "generates key on creation" do
    expect(FactoryGirl.create(:recovery, email: FactoryGirl.create(:user).email).key).to be_present
  end

end
