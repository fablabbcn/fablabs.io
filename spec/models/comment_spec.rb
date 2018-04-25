require 'spec_helper'

describe Comment, type: :model  do

  it { should belong_to(:author)}
  it { should belong_to(:commentable)}

  it { should validate_presence_of(:author)}
  it { should validate_presence_of(:commentable)}

  it "is valid" do
    expect(FactoryGirl.create(:comment)).to be_valid
  end

  it "has ancestry" do
    dad = FactoryGirl.create(:comment)
    child = FactoryGirl.create(:comment, parent: dad)
    expect(dad.children).to include(child)
  end

end
