require 'spec_helper'

describe Project do
  let(:project) { FactoryGirl.create(:project) }

  it { should have_one(:title) }
  it { should have_one(:description) }
  it { should have_one(:github) }
  it { should have_one(:web) }
  it { should have_one(:bitbucket) }
  it { should have_one(:dropbox) }
  it { should have_many(:contributions) }
  it { should have_many(:contributors).through(:contributions) }
  it { should belong_to(:owner) }
  it { should belong_to(:lab) }

  it "is valid" do
    expect(lab).to be_valid
  end

  it "has to_s" do
    expect(FactoryGirl.build_stubbed(:project, title: "Great New Project").to_s).to eq("Great New Project")
  end

  
end
