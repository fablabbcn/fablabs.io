require 'spec_helper'

describe Event do

  it { should belong_to(:lab) }
  it { should belong_to(:creator) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:lab) }
  it { should validate_presence_of(:starts_at) }

end
