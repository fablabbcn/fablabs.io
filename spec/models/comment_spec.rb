require 'spec_helper'

describe Comment, type: :model  do

  it { should belong_to(:author)}
  it { should belong_to(:commentable)}

  it { should validate_presence_of(:author)}
  it { should validate_presence_of(:commentable)}

  it "is valid" do
    expect(FactoryBot.create(:comment)).to be_valid
  end

  it "has ancestry" do
    dad = FactoryBot.create(:comment)
    child = FactoryBot.create(:comment, parent: dad)
    expect(dad.children).to include(child)
  end

end
