require 'spec_helper'

describe Facility, type: :model  do
  it { should belong_to(:thing) }
  it { should belong_to(:lab) }
end
