require 'spec_helper'

describe Coupon, type: :model  do

  it { should belong_to(:user) }
  it { should validate_presence_of(:user) }

  it "should generate code" do
    expect(FactoryBot.create(:coupon).code).to be_present
  end

end
