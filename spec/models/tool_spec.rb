require 'spec_helper'

describe Tool do
  it { should belong_to(:brand) }
  it { should have_many(:facilities) }
  it { should have_many(:discussions) }
  it { should have_many(:labs).through(:facilities) }
  it { should validate_presence_of(:name) }

  it "is valid" do
    expect(FactoryGirl.build(:tool)).to be_valid
  end

  it "is taggable" do
    tool = FactoryGirl.create(:tool, tag_list: [:cheese, :salt_and_vinegar])
    expect(tool.tags.map(&:name)).to eq(['salt_and_vinegar', 'cheese'])
  end

  it "has to_s" do
    expect(FactoryGirl.build(:tool, name: 'hammer').to_s).to eq('hammer')
  end

end
