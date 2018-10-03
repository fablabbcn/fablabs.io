require 'spec_helper'

describe Link, type: :model  do

  it { should belong_to(:linkable) }
  it { should validate_presence_of(:url) }

  it "is valid" do
    expect(FactoryBot.create(:link)).to be_valid
  end

  it "adds http" do
    expect(FactoryBot.create(:link, url: 'facebook.com').url).to eq('http://facebook.com')
  end

  it "has unique url" do
    lab = FactoryBot.create(:lab)
    FactoryBot.create(:link, url: 'facebook.com', linkable: lab)
    expect{FactoryBot.create(:link, url: 'facebook.com', linkable: lab)}.to raise_error ActiveRecord::RecordInvalid
  end

  it "adds http when necessary" do
    %w(facebook.com 0.0.0.0).each do |url|
      expect(FactoryBot.create(:link, url: url).url).to eq("http://#{url}")
    end
  end

  describe "social scopes" do

    it "has .twitter_urls" do
      FactoryBot.create(:link, url: 'http://www.twitter.com/john_rees')
      FactoryBot.create(:link, url: 'http://www.twitter.com/#/gem')
      FactoryBot.create(:link, url: 'http://facebook.com/twitter')
      FactoryBot.create(:link, url: 'http://twitter.com/fablabsio')

      expect(Link.twitter_urls).to eq([
        'http://www.twitter.com/john_rees',
        'http://www.twitter.com/#/gem',
        'http://twitter.com/fablabsio'
      ])
    end

  end

end
