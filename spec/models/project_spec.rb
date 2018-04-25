require 'spec_helper'

describe Project, type: :model  do
  let(:project) { FactoryGirl.create(:project) }

  it { should have_many(:contributions) }
  it { should have_many(:contributors).through(:contributions) }
  it { should have_many(:collaborators).through(:collaborations) }
  it { should have_many(:devices).through(:machineries) }
  it { should have_many(:documents)}
  it { should belong_to(:owner) }
  it { should belong_to(:lab) }

  it "is valid" do
    expect(project).to be_valid
  end

end
