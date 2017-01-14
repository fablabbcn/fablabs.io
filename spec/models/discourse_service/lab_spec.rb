require 'spec_helper'

describe DiscourseService::Lab do

  let(:lab){ FactoryGirl.create(:lab)}
  let(:discourse_lab) { DiscourseService::Lab.new(lab) }

  it '#name' do
    expect(discourse_lab.name).to eq("Discussion about #{lab.name}")
  end

  it '#description' do
    expect(discourse_lab.description).to match(/#{lab.description}/)
    expect(discourse_lab.description).to match(/#{discourse_lab.url}/)
  end

  it '#url' do
    expect(discourse_lab.url).to match(/#{Rails.application.routes.url_helpers.lab_path(lab)}/)
  end
end
