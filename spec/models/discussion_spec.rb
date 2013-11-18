require 'spec_helper'

describe Discussion do
  it { should belong_to(:discussable) }
  it { should belong_to(:creator) }
  it { should validate_presence_of(:creator) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:body) }
end
