require 'rails_helper'

describe Api::V2::LabsController, :type => :request do
  default_version 2

  describe 'GET labs#index' do

    context "When authenticated"
    let!(:user) { FactoryGirl.create :user }
    let!(:lab) { FactoryGirl.create(:lab, workflow_state: 'approved', name: "Fab Lab BCN") }
    let!(:lab2) { FactoryGirl.create(:lab, name: "Fab Lab Toscana") }
    
    it "Lists labs as normal user" do
      get_as_user 'http://api.fablabs.dev/2/labs'
      # expect(json['users']).to match_array([user_helper(user)])
      
      expect(response.status).to eq(200)
      expect(response.content_type).to eq(Mime::JSON)
      
      expect(json["data"].size).to eq(1)

      @lab = json["data"][0]
      expect(@lab["type"]).to eq("lab")
      expect(@lab["attributes"]["name"]).to eq(lab.name)
      # expect(response.parsed_body).to eq({error:"Not authorized"})
    end


  end

  describe 'get labs#search' do

    context "When authenticated"
    let!(:user) { FactoryGirl.create :user }
    let!(:lab2) { FactoryGirl.create(:lab, 
      workflow_state: 'approved', 
      name: "Fab Lab Toscana",
      latitude: 43.722,
      longitude: 10.4017
      ) 
    }
    let!(:lab) { FactoryGirl.create( :lab, 
      workflow_state: 'approved', 
      name: "Fab Lab BCN",
      latitude: 41.385,
      longitude: 2.173) }
    
    let!(:lab3) { FactoryGirl.create( :lab, 
        workflow_state: 'approved', 
        name: "Beach lab Sitges",
        latitude: 41.237,
        longitude: 1.805) }

    it "Allows to search labs by name as normal user" do

      get_as_user "http://api.fablabs.dev/2/labs/search",  
        {q: "toscana", type: "fulltext"}

      expect(response.status).to eq(200)
      expect(response.content_type).to eq(Mime::JSON)
      
      expect(json["data"].size).to eq(1)

      @lab = json["data"][0]
      expect(@lab["type"]).to eq("lab")
      expect(@lab["attributes"]["name"]).to eq(lab2.name)

    end

    it "Allows to search labs by location" do
      @lat = 41.385 # barcelona
      @lng =  2.173
      get_as_user "http://api.fablabs.dev/2/labs/search?q=#{@lat}:#{@lng}&type=location"

      expect(response.status).to eq(200)
      expect(response.content_type).to eq(Mime::JSON)
      
      expect(json["data"].size).to eq(2)

      @tmp_lab = json["data"][0]
      expect(@tmp_lab["type"]).to eq("lab")
      expect(@tmp_lab["attributes"]["name"]).to eq(lab.name)
      @tmp_lab = json["data"][1]
      expect(@tmp_lab["type"]).to eq("lab")
      expect(@tmp_lab["attributes"]["name"]).to eq(lab3.name)
    end

  end
  describe 'get labs#map' do

    context "When authenticated"
    let!(:user) { FactoryGirl.create :user }
    let!(:lab2) { FactoryGirl.create(:lab, 
      workflow_state: 'approved', 
      name: "Fab Lab Toscana",
      latitude: 43.722,
      longitude: 10.4017
      ) 
    }
    let!(:lab) { FactoryGirl.create( :lab, 
      workflow_state: 'approved', 
      name: "Fab Lab BCN",
      latitude: 41.385,
      longitude: 2.173) }

    it "Allows to list labs coordinates as normal user" do

      get_as_user "http://api.fablabs.dev/2/labs/map"

      expect(response.status).to eq(200)
      expect(response.content_type).to eq(Mime::JSON)
      
      expect(json["data"].size).to eq(2)

      @labs = json["data"]
      @labs.each do |lab|
        expect(lab["type"]).to eq("lab")
        expect(lab["attributes"].keys).to match_array(["latitude","longitude","name","id","slug","url"])
      end
    end
  end
end