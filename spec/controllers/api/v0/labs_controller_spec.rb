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
      get 'http://api.fablabs.dev/0/labs.json'
      json_body = JSON.parse(response.body)
      expect(json_body.length).to eq(100)
    end
  end


  describe 'GET labs#show.json' do    

    it "doesn't return any error when lab exists" do
      @lab = FactoryBot.create(:lab, {
        name: "MyLab#{Lab.count}",
        kind: Lab::KINDS[1],
        email: 'some@email.com',
        country_code: 'IS',
          description: 'Something',
          blurb: 'Something',
          phone: '+324324324',
        address_1: 'MyStreet 24',
        network: true,
        tools: true,
        programs: true,
        workflow_state: 'approved',
        latitude: 64.963,
        longitude: 19.0208
      }
        # referee_id: 1
      )
  
      @euser= FactoryBot.create(:user, first_name: "Homer", last_name: "Simpson") 
      @employee = FactoryBot.create(:employee, user: @euser, lab: @lab, job_title: "Nuclear Safety Inspector")
      @employee.approve! 
   
      get "http://api.fablabs.dev/0/labs/#{@lab.id}.json" 
      expect(response.status).to eq(200)
      expect(response.content_type).to eq(Mime::JSON)

      json_body = JSON.parse(response.body)
      expect(json_body['avatar_url']).to eq(@lab.avatar_url)
      expect(json_body['employees'].length).to eq(1)
      expect(json_body['employees'][0]["user"]["username"]).to eq(@euser.username)      
      expect(json_body['employees'][0]["user"]["avatar_url"]).to eq(@euser.avatar_url)      
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
          description: 'Something',
          blurb: 'Something',
          phone: '+324324324',
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
