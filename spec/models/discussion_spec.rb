require 'spec_helper'

describe Discussion do
  it { should belong_to(:discussable) }
  it { should belong_to(:creator) }
end
