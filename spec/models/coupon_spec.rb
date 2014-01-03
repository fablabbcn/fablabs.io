require 'spec_helper'

describe Coupon do

  it { should belong_to(:user) }
  it { should validate_presence_of(:user) }

  it "should generate code" do
    expect(FactoryGirl.create(:coupon).code).to be_present
  end

end
