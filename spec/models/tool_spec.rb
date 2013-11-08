require 'spec_helper'

describe Tool do
  it { should validate_presence_of(:name) }
  it { should belong_to(:brand) }
end
