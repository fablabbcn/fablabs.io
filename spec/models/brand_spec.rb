require 'spec_helper'

describe Brand, type: :model  do
  it { should validate_presence_of(:name) }

  it "is valid" do
    expect(FactoryBot.create(:brand)).to be_valid
  end

  it "has to_s" do
    expect(FactoryBot.build_stubbed(:brand, name: 'Makerbot Industries').to_s).to eq('Makerbot Industries')
  end

end
