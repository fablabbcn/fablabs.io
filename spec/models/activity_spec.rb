require 'spec_helper'

describe Activity, type: :model  do

  it { should belong_to(:creator) }
  it { should belong_to(:actor) }
  it { should belong_to(:trackable) }

  it "has default_scope" do
    a = FactoryBot.create(:activity)
    b = FactoryBot.create(:activity)
    expect(Activity.all).to eq([b,a])
  end

  it "has .actioned" do
    expect(FactoryBot.build_stubbed(:activity, action: 'create').actioned).to eq('created')
    expect(FactoryBot.build_stubbed(:activity, action: 'updated').actioned).to eq('updated')
    expect(FactoryBot.build_stubbed(:activity, action: 'destroy').actioned).to eq('destroyed')
  end

end
