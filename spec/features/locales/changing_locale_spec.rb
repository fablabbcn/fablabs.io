require 'spec_helper'

feature "Changing locale" do

  skip "as a visitor" do
    visit root_path
    click_link('locale-icon')
    expect(page).to have_content('Choose Your Language')
    click_link 'Español'
    expect(current_url).to include('?locale=es')
    expect(page).to have_css('#locale-icon.es')
  end

  skip "as a user" do
    user = FactoryGirl.create(:user, locale: 'es')
    sign_in user
    click_link('locale-icon')
    click_link 'English'
    user.reload
    expect(user.locale).to eq('en')
    expect(page).to have_css('#locale-icon.en')
  end

end
