require 'spec_helper'

describe AdminApplication do
  it { should belong_to(:lab) }
  it { should belong_to(:applicant) }
  it { should validate_presence_of(:lab) }
  it { should validate_presence_of(:applicant) }
end
