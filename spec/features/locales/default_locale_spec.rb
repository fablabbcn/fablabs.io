require 'spec_helper'

feature "Default locale" do

  skip "as a visitor" do
    I18n.locale = 'en'
    visit root_path
    expect(page).to have_css('#locale-icon.en')
    I18n.locale = I18n.default_locale
  end

  skip "as a user" do
    user = FactoryGirl.create(:user, locale: 'es')
    sign_in user
    expect(page).to have_css('#locale-icon.es')
  end

end
