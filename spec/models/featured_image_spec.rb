require 'spec_helper'

describe FeaturedImage do
  it { should validate_presence_of(:src) }
end
