require 'rails_helper'



describe Api::V2::AdminController, :type => :request do
  default_version 2

  describe 'GET users#index' do
    context "When not authenticated"


    it "Does not allow to list users" do
      get 'http://api.fablabs.dev/2/users'
      expect(response.status).to eq(401)
      expect(response.content_type).to eq(Mime::JSON)
      # expect(response.parsed_body).to eq({error:"Not authorized"})
    end

    context "When authenticated"
    let!(:user) { FactoryGirl.create :user }

    it "Does not allow to list users as normal user" do
      get_as_user 'http://api.fablabs.dev/2/users'
      # expect(json['users']).to match_array([user_helper(user)])
      expect(response.status).to eq(403)
      expect(response.content_type).to eq(Mime::JSON)
      # expect(response.parsed_body).to eq({error:"Not authorized"})
    end

    context "When authenticated as admin"


    it "Does allow to list users as an admin" do
      user.add_role :superadmin
      get_as_user 'http://api.fablabs.dev/2/users'
      # expect(json['users']).to match_array([user_helper(user)])
      expect(response.status).to eq(200)
      expect(response.content_type).to eq(Mime::JSON)
      # expect(response.parsed_body).to eq({error:"Not authorized"})
    end

  end






end
