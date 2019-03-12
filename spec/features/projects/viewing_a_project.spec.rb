# frozen_string_literal: true

require 'spec_helper'

feature 'Viewing a project' do
  given(:project) { FactoryBot.create(:project) }

  scenario 'as a visitor' do
    visit project_path(project)
    expect(page).to have_title(project.title)
  end

  scenario 'as a user' do
    sign_in
    visit project_path(project)
    expect(page).to have_title(project.title)
  end

  scenario 'as an admin' do
    sign_in_superadmin
    visit project_path(project)
    expect(page).to have_title(project.title)
  end
end
