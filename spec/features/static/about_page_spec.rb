require 'spec_helper'

feature "About page" do

  scenario "as anyone" do
    visit about_path
    expect(page).to have_title("About")
  end

end
