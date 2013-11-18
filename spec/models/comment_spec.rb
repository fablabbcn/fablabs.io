require 'spec_helper'

describe Comment do
  it { should validate_presence_of(:author)}
  it { should belong_to(:author)}
end
