require 'spec_helper'

describe Facility do
  it { should belong_to(:tool) }
  it { should belong_to(:lab) }
  it { should validate_presence_of(:tool) }
  it { should validate_presence_of(:lab) }
end
