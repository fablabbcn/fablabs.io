require 'rails_helper'

describe Api::V2::ProjectsController, :type => :request do
  let!(:user) { FactoryBot.create :user }
  let!(:owner) { FactoryBot.create :user }
  let!(:lab) { FactoryBot.create(:lab, name: "Fab Lab BCN", slug: "fablabbcn", workflow_state: :approved) }
  let!(:project) { FactoryBot.create(:project, owner: owner, lab: lab) }

  describe 'GET projects#index' do

    context "When not authenticated"

    it "Does not allow to list projects as anonymous" do
      get 'http://api.fablabs.dev/2/projects'

      expect(response.status).to eq(401)
      expect(response.media_type).to eq(Mime[:json].to_s)
    end


    context "When authenticated"


    it "Allows user to list projects" do
      get_as_user 'http://api.fablabs.dev/2/projects'
      expect(response.status).to eq(200)
      expect(response.media_type).to eq(Mime[:json].to_s)

      expect(json["data"].size).to eq(1)

      @tmp_project = json["data"][0]
      expect(@tmp_project["type"]).to eq("project")
      expect(@tmp_project["attributes"]["id"]).to eq(project.id)
    end
  end

  describe 'GET projects#show' do
    context "When not authenticated" do

      it "Does not allow to access a project as anonymous" do
        get "http://api.fablabs.dev/2/projects/#{project.id}"

        expect(response.status).to eq(401)
        expect(response.media_type).to eq(Mime[:json].to_s)

      end
    end

    context "When authenticated" do

      it "Allows user to access a project" do
        get_as_user "http://api.fablabs.dev/2/projects/#{project.id}"

        expect(response.status).to eq(200)
        expect(response.media_type).to eq(Mime[:json].to_s)

        # expect(json["data"].size).to eq(1)

        @tmp_project = json["data"]
        expect(@tmp_project["type"]).to eq("project")
        expect(@tmp_project["attributes"]["id"]).to eq(project.id)    
      end
    end
  end

  describe 'GET projects#search' do

    context "When not authenticated" do
      it "Does not allow to search for projects as anonymous" do
        get 'http://api.fablabs.dev/2/projects/search', params: {q: project.title}

        expect(response.status).to eq(401)
        expect(response.media_type).to eq(Mime[:json].to_s)

      end
    end

    context "When authenticated" do
      it "Allows user to search for a project, returning the correct result" do
        get_as_user "http://api.fablabs.dev/2/projects", q: project.title
        expect(response.status).to eq(200)
        expect(response.media_type).to eq(Mime[:json].to_s)

        expect(json["data"].size).to eq(1)

        @tmp_project = json["data"][0]
        expect(@tmp_project["type"]).to eq("project")
        expect(@tmp_project["attributes"]["id"]).to eq(project.id)    
        expect(@tmp_project["attributes"]["title"]).to eq(project.title)    
      end


      it "Returns empty results for a search without matches" do
        get_as_user "http://api.fablabs.local/2/projects/search", q: "aeiou3248093840"
        expect(response.status).to eq(200)
        expect(response.media_type).to eq(Mime[:json].to_s)
        expect(json["data"].size).to eq(0)
      end
    end

    describe 'GET /api/v2/projects/map' do
      before do

        15.times do
          owner = FactoryBot.create(:user)
          lab = FactoryBot.create(:lab, workflow_state: :approved)
          project = FactoryBot.create(:project, lab: lab, owner: owner)
        end

        get_as_user "http://api.fablabs.dev/2/projects/map", options: { page: 1, per_page: 5 }
      end

      it 'returns paginated project map data' do
        json = JSON.parse(response.body)
        puts response.body
        expect(json["data"].length).to eq(5)
        expect(json["meta"]).to include("total-pages")
        expect(json["links"]).to include("self", "next")
      end
    end

  end

end
