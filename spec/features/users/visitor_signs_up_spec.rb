require 'spec_helper'

feature "Visitor signs up" do

  scenario 'with valid details' do
    sign_up_as FactoryGirl.build(:user)
    expect(page).to have_content('Sign out')
  end

  scenario 'with invalid email' do
    sign_up_as FactoryGirl.build(:user, email: 'wrong')
    expect(page).to have_content('Sign In')
  end

  scenario 'with blank password' do
    sign_up_as FactoryGirl.build(:user, password: '', password_confirmation: '')
    expect(page).to have_content('Sign In')
  end

end
