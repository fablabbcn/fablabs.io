require 'spec_helper'

describe Link do

  it { should belong_to(:linkable) }
  it { should validate_presence_of(:url) }
  it { should validate_uniqueness_of(:url).scoped_to([:linkable_id, :linkable_type]) }

  it "doesn't allow invald URL" do
    expect{FactoryGirl.create(:link, url: 'wrong')}.to raise_error(ActiveRecord::RecordInvalid)
  end

end
