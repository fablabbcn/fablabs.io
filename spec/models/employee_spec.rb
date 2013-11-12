require 'spec_helper'

describe Employee do
  it { should belong_to(:user) }
  it { should belong_to(:lab) }
  it { should validate_presence_of(:user) }
  it { should validate_presence_of(:lab) }
  it { should validate_uniqueness_of(:user_id).scoped_to(:lab_id) }

  pending "orders by ordinal, name ASC" do
    order = [2,1,1]
    %w(aardvark zebra lion).each do |name|
      user = FactoryGirl.create(:user, first_name: name)
      FactoryGirl.create(:employee, user: user, ordinal: order.unshift)
    end
    expect(Employee.all.map{ |e| e.user.first_name }).to eq(%w(lion zebra aardvark))
  end

end
