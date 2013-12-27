require 'spec_helper'

describe Page do

  it { should belong_to(:pageable) }
  it { should belong_to(:creator) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:body) }
  it { should validate_presence_of(:creator) }
  it { should validate_presence_of(:pageable) }

end
