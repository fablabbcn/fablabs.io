require 'spec_helper'

describe Brand do
  it { should validate_presence_of(:name) }
end
