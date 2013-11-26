require 'spec_helper'

describe 'locale' do

  it "has default locale" do
    I18n.locale = I18n.default_locale
    visit root_path
    expect(page).to have_css('#locale-icon.en')
  end

  it "can change locale" do
    visit root_path
    click_link('locale-icon')
    expect(page).to have_content('Choose Your Language')
    click_link 'Español'
    expect(current_url).to include('?locale=es')
    expect(page).to have_css('#locale-icon.es')
  end

  it "respects users' locale" do
    user = FactoryGirl.create(:user, locale: 'es')
    signin user
    expect(page).to have_css('#locale-icon.es')
  end

  it "updates user locale" do
    user = FactoryGirl.create(:user, locale: 'es')
    signin user
    click_link('locale-icon')
    click_link 'English'
    user.reload
    expect(user.locale).to eq('en')
    expect(page).to have_css('#locale-icon.en')
  end

end
