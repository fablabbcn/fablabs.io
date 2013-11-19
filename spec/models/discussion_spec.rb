require 'spec_helper'

describe Discussion do
  it { should belong_to(:discussable) }
  it { should belong_to(:creator) }
  it { should validate_presence_of(:creator) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:body) }
  it { should validate_presence_of(:discussable) }

  # it "has initial state" do
  #   expect(FactoryGirl.build(:discussion).current_state).to eq('open')
  # end
end
