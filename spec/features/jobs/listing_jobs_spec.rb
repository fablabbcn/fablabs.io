require 'spec_helper'

feature "Listing jobs" do

  job = FactoryBot.create(:job, title: "System administrator")

  scenario "as a visitor" do
    visit jobs_path
    expect(page).to have_title('Jobs')
    expect(page).to have_link('System administrator')
  end

  scenario "as a user" do
    sign_in
    visit jobs_path
    expect(page).to have_title('Jobs')
    expect(page).to have_link('System administrator')
  end

  scenario "as an admin" do
    sign_in_superadmin
    job.reload
    visit jobs_path
    expect(page).to have_title('Jobs')
    expect(page).to have_link('System administrator')
  end

end
