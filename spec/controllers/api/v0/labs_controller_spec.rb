# frozen_string_literal: true

require 'rails_helper'

describe Api::V0::LabsController, type: :request do
  default_version 0

  describe 'GET labs#index.json' do
    context 'When not authenticated'

    it "doesn't produce any error" do
      get 'http://api.fablabs.dev/0/labs.json'
      expect(response.status).to eq(200)
      expect(response.content_type).to eq(Mime::JSON)
    end

    it 'gives all the results back' do
      100.times do
        @lab = Lab.create!(
          name: "MyLab#{Lab.count}",
          kind: Lab::KINDS[1],
          email: 'some@email.com',
          country_code: 'IS',
          address_1: 'MyStreet 24',
          network: true,
          tools: true,
          programs: true,
          workflow_state: 'approved',
          latitude: 64.963,
          longitude: 19.0208
          # referee_id: 1
        )
      end
      get 'http://api.fablabs.dev/0/labs.json'
      json_body = JSON.parse(response.body)
      expect(json_body.length).to eq(100)
    end
  end

  describe 'GET labs#map.json' do
    context 'When not authenticated'

    it "doesn't produce any error" do
      get 'http://api.fablabs.dev/0/labs/map.json'
      expect(response.status).to eq(200)
      expect(response.content_type).to eq(Mime::JSON)
    end

    it 'gives all the results back' do
      1000.times do
        @lab = Lab.create!(
          name: "MyLab#{Lab.count}",
          kind: Lab::KINDS[1],
          email: 'some@email.com',
          country_code: 'IS',
          address_1: 'MyStreet 24',
          network: true,
          tools: true,
          programs: true,
          workflow_state: 'approved',
          latitude: 64.963,
          longitude: 19.0208
          # referee_id: 1
        )
      end
      get 'http://api.fablabs.dev/0/labs/map.json'
      json_body = JSON.parse(response.body)
      expect(json_body.length).to eq(1000)
    end
  end
end
