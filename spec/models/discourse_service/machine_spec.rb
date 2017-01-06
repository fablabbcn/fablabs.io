require 'spec_helper'

describe DiscourseService::Machine do

  let(:machine){ FactoryGirl.create(:machine)}
  let(:discourse_machine) { DiscourseService::Machine.new(machine) }

  it '#name' do
    expect(discourse_machine.name).to eq("Discussion about #{machine.brand.try(:name)} #{machine.name}")
  end

  it '#description' do
    expect(discourse_machine.description).to match(/#{discourse_machine.name}/)
    expect(discourse_machine.description).to match(/#{discourse_machine.url}/)
  end

  it '#url' do
    expect(discourse_machine.url).to match(/#{Rails.application.routes.url_helpers.machine_path(machine)}/)
  end
end
