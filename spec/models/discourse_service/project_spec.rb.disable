require 'spec_helper'

describe DiscourseService::Project do

  let(:project){ FactoryBot.create(:project)}
  let(:discourse_project) { DiscourseService::Project.new(project) }

  it '#name' do
    expect(discourse_project.name).to eq("Discussion about #{project.title}")
  end

  it '#description' do
    expect(discourse_project.description).to match(/#{discourse_project.url}/)
  end

  it '#url' do
    expect(discourse_project.url).to match(/#{Rails.application.routes.url_helpers.project_path(project)}/)
  end
end
