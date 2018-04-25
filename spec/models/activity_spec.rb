require 'spec_helper'

describe Activity, type: :model  do

  it { should belong_to(:creator) }
  it { should belong_to(:actor) }
  it { should belong_to(:trackable) }

  it "has default_scope" do
    a = FactoryGirl.create(:activity)
    b = FactoryGirl.create(:activity)
    expect(Activity.all).to eq([b,a])
  end

  it "has .actioned" do
    expect(FactoryGirl.build_stubbed(:activity, action: 'create').actioned).to eq('created')
    expect(FactoryGirl.build_stubbed(:activity, action: 'updated').actioned).to eq('updated')
    expect(FactoryGirl.build_stubbed(:activity, action: 'destroy').actioned).to eq('destroyed')
  end

end
