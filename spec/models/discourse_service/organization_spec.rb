require 'spec_helper'

describe DiscourseService::Organization do

  let(:organization){ FactoryGirl.create(:organization)}
  let(:discourse_organization) { DiscourseService::Organization.new(organization) }

  it '#name' do
    expect(discourse_organization.name).to eq("Discussion about #{organization.name}")
  end

  it '#description' do
    expect(discourse_organization.description).to match(/#{discourse_organization.url}/)
  end

  it '#url' do
    expect(discourse_organization.url).to match(/#{Rails.application.routes.url_helpers.organization_path(organization)}/)
  end
end
