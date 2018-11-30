require 'rails_helper'

RSpec.feature "Login Process", type: :feature do
  before :each do
    @user = FactoryBot.create(:user, :password => 'password')
  end	


  it "signs me in" do
    visit '/sessions/new'
    within('.signinpanel') do
      fill_in 'Email or Username', :with => @user.email 
      fill_in 'Password', :with => 'password'
      find('input[name="commit"]').click
    end
    expect(page).to have_no_content("Invalid email or password")
    expect(page).to have_selector(".avatar")
  end

end
