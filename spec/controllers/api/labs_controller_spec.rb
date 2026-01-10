# frozen_string_literal: true

require 'rails_helper'

describe Api::LabsController, type: :request do
  describe 'GET labs#index.json' do
    context 'When not authenticated'

    it "doesn't produce any error" do
      get 'http://www.fablabs.dev/api/labs.json'
      expect(response.status).to eq(200)
      expect(response.media_type).to eq(Mime[:json].to_s)
    end

    it 'gives all the results back' do
      100.times do
        @lab = Lab.create!(
          name: "MyLab#{Lab.count}",
          kind: Lab::KINDS[1],
          email: 'some@email.com',
          country_code: 'IS',
          address_1: 'MyStreet 24',
          description: 'Something',
          blurb: 'Something',
          phone: '+324324324',
          network: true,
          tools: true,
          programs: true,
          workflow_state: 'approved',
          latitude: 64.963,
          longitude: 19.0208
          # referee_id: 1
        )
      end
      get 'http://www.fablabs.dev/api/labs.json'
      json_body = JSON.parse(response.body)
      expect(json_body.length).to eq(100)
    end
  end
  
end
