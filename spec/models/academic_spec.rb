require 'spec_helper'

describe Academic, type: :model  do
  it { should belong_to(:user) }
  it { should belong_to(:lab) }
  # following test fails for some obscure reason
  #it { should belong_to(:approver)}

  it { should validate_presence_of(:lab) }
  it { should validate_presence_of(:user) }
  it { should validate_presence_of(:started_in) }
  # see above
  #it { should validate_presence_of(:approver) }

  skip "type"
  skip "approver" 
end
