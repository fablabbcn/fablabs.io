require 'spec_helper'
require 'rspec_api_documentation/dsl'

resource "Labs", :ignore do
  get "http://api.fablabs.dev/1/labs" do
    example "Listing labs" do
      3.times do
        lab = FactoryGirl.create(:lab)
        lab.approve!
      end
      do_request
      status.should == 200
    end
  end
end
