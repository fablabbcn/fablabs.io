require 'spec_helper'

feature "Viewing a job" do

  given!(:job) { FactoryBot.create(:job, title: "System administrator") }

  scenario "as a visitor" do
    visit job_path(job)
    expect(page).to have_text(job.title)
  end

  scenario "as a user" do
    sign_in
    visit job_path(job)
    expect(page).to have_text(job.title)
  end

  scenario "as an admin" do
    sign_in_superadmin
    visit job_path(job)
    expect(page).to have_text(job.title)
  end

end
