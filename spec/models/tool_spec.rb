require 'spec_helper'

describe Machine, type: :model  do
  it { should belong_to(:brand) }
  it { should have_many(:facilities) }
  it { should have_many(:discussions) }
  it { should have_many(:labs).through(:facilities) }
  it { should validate_presence_of(:name) }

  it "is valid" do
    expect(FactoryBot.build(:machine)).to be_valid
  end

  it "is taggable" do
    machine = FactoryBot.create(:machine)
    machine.tag_list.add :cheese
    machine.tag_list.add :salt_and_vinegar
    machine.save
    expect(machine.tag_list).to eq(['cheese', 'salt_and_vinegar'])
    expect(machine.tags.order(:name).map(&:name)).to eq(['cheese', 'salt_and_vinegar'])
  end

  it "has to_s" do
    expect(FactoryBot.build(:machine, name: 'hammer').to_s).to eq('hammer')
  end

end
