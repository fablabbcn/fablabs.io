require 'spec_helper'

describe 'static' do

  it "has about page" do
    visit about_path
    expect(page).to have_title("About")
  end

  it "has developers page" do
    visit developers_path
    expect(page).to have_title("Developers")
  end

end
