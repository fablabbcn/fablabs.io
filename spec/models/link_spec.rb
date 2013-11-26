require 'spec_helper'

describe Link do

  it { should belong_to(:linkable) }
  it { should validate_presence_of(:url) }

  it "is valid" do
    expect(FactoryGirl.create(:link)).to be_valid
  end

  it "adds http" do
    expect(FactoryGirl.create(:link, url: 'facebook.com').url).to eq('http://facebook.com')
  end

  it "has unique url" do
    lab = FactoryGirl.create(:lab)
    FactoryGirl.create(:link, url: 'facebook.com', linkable: lab)
    expect{FactoryGirl.create(:link, url: 'facebook.com', linkable: lab)}.to raise_error
  end

  pending "doesn't allow invald URL" do
    expect{FactoryGirl.create(:link, url: 'wrong')}.to raise_error(ActiveRecord::RecordInvalid)
  end

end
