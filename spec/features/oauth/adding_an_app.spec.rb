require 'spec_helper'

feature "Adding an oAuth app" do

    scenario "as a visitor" do
        visit oauth_applications_path
        expect(page.title).to match('Sign in')
      end

    feature "as an authenticated user" do

        given(:user) { FactoryBot.create(:user) }

        background do
            user.verify!
            sign_in user
            visit oauth_applications_path
            click_link 'New Application'
        end

        scenario "an authenticated user with all the details filled in" do
            fill_in 'doorkeeper_application[name]', with: 'My fab project'
            fill_in 'doorkeeper_application[redirect_uri]', with: 'http://localhost:8080/oauth/callback'
            click_button 'Submit'
            expect(page).to have_content('Application created.')
            expect(page).to have_content('Personal access token:')
        end

        scenario "an authenticated user with missing redirect url" do
            fill_in 'doorkeeper_application[name]', with: 'My fab project'
            click_button 'Submit'
            expect(page).to have_content('Whoops! Check your form for possible errors')
            expect(page).to have_content("Can't be blank")
        end

        scenario "an authenticated user with missing app name" do
            fill_in 'doorkeeper_application[redirect_uri]', with: 'http://localhost:8080/oauth/callback'
            click_button 'Submit'
            expect(page).to have_content('Whoops! Check your form for possible errors')
            expect(page).to have_content("Can't be blank")
        end
    end
end