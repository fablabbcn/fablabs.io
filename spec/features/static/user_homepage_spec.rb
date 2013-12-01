require 'spec_helper'

describe "User homepage" do

  it "redirects to labs_path" do
    sign_in
    visit root_path
    expect(current_path).to eq(labs_path)
  end

end
