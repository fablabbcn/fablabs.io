require 'spec_helper'

RSpec.describe Event, type: :model do
  let(:event) { FactoryGirl.create(:event) }

  it { should belong_to(:lab) }
  it { should belong_to(:creator) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:lab) }

  pending { should validate_presence_of(:starts_at) }

  # attr_accessor :all_day, :location, :time_zone
  # attr_writer :start_date, :start_time, :end_date, :end_time

  it "has upcoming scope" do
    past = FactoryGirl.create(:event, starts_at: (Time.zone.now - 1.week))
    future = FactoryGirl.create(:event, starts_at: (Time.zone.now + 1.week))
    expect(Event.upcoming).to include(future)
    expect(Event.upcoming).to_not include(past)
  end

  it "has start_time"
  it "has start_date"
  it "has end_time"
  it "has end_date"

  it "has time_zone" do
    expect(FactoryGirl.create(:event).time_zone).to eq('Madrid')
  end

  it "sets timezones"

  it "has to_s" do
    expect(FactoryGirl.create(:event, name: 'open day').to_s).to eq('open day')
  end

  it "has all_day?"

  describe "tags" do

    it "has tags" do
      expect(Event::Tags).to include('open_days')
    end

    it "has bitmask" do
      expect(event.tags?(:open_days)).to be false
      event.tags << :open_days#, :workshops]
      expect(event.tags?(:open_days)).to be true
    end

  end

  it "parses time"

end
