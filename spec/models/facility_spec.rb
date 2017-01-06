require 'spec_helper'

describe Facility, type: :model do
  it { should belong_to(:thing) }
  it { should belong_to(:lab) }
  it { should validate_presence_of(:thing) }
  it { should validate_presence_of(:lab) }
end
