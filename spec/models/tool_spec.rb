require 'spec_helper'

describe Tool do
  it { should validate_presence_of(:name) }
  it { should belong_to(:brand) }
  it { should have_many(:facilities) }
  it { should have_many(:labs).through(:facilities) }
end
