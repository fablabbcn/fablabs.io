require 'spec_helper'

describe Facility do
  it { should belong_to(:thing) }
  it { should belong_to(:lab) }
end
