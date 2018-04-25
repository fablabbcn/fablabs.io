require 'spec_helper'

describe Link, type: :model  do

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

  it "adds http when necessary" do
    %w(facebook.com 0.0.0.0).each do |url|
      expect(FactoryGirl.create(:link, url: url).url).to eq("http://#{url}")
    end
  end

  describe "social scopes" do

    it "has .twitter_urls" do
      FactoryGirl.create(:link, url: 'http://www.twitter.com/john_rees')
      FactoryGirl.create(:link, url: 'http://www.twitter.com/#/gem')
      FactoryGirl.create(:link, url: 'http://facebook.com/twitter')
      FactoryGirl.create(:link, url: 'http://twitter.com/fablabsio')

      expect(Link.twitter_urls).to eq([
        'http://www.twitter.com/john_rees',
        'http://www.twitter.com/#/gem',
        'http://twitter.com/fablabsio'
      ])
    end

  end

end
