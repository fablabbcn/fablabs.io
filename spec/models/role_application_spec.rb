require 'spec_helper'

describe RoleApplication do
  it { should validate_presence_of(:user) }
  it { should validate_presence_of(:lab) }
  it { should validate_presence_of(:description) }
  it { should belong_to(:lab)}
  it { should belong_to(:user)}
end
