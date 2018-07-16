require 'rails_helper'

describe Api::V2::UserController, :type => :request do
  default_version 2

  let!(:user) { FactoryGirl.create :user }
  let!(:admin) { FactoryGirl.create :user }

  context "When not authenticated"
  it "Does not allow to access a user profile as an anonymous user" do
    get  'http://api.fablabs.dev/2/users/' + user.username
    expect(response.status).to eq(401)
    expect(response.content_type).to eq(Mime::JSON)
    # expect(response.parsed_body).to eq({error:"Not authorized"})
  end


  it "Does not allow to access a user profile as a normal user" do
    get_as_user 'http://api.fablabs.dev/2/users/' + user.username
    expect(response.status).to eq(403)
    expect(response.content_type).to eq(Mime::JSON)
    # expect(response.parsed_body).to eq({error:"Not authorized"})
  end

  context "When authenticated"

  it "Does allow to get user as a superadmin" do
    get_as_admin 'http://api.fablabs.dev/2/users/' + user.username
    # expect(json['users']).to match_array([user_helper(user)])
    expect(response.status).to eq(200)
    expect(response.content_type).to eq(Mime::JSON)
    # expect(response.parsed_body).to eq({error:"Not authorized"})
  end

  it "Does allow to get the current user profile" do
    get_as_user 'http://api.fablabs.dev/2/users/me'
    expect(response.status).to eq(200)
    expect(response.content_type).to eq(Mime::JSON)
    expect(json["data"]["attributes"]["username"]).to eq(user.username)
    # expect(response.parsed_body).to eq({error:"Not authorized"})
  end


end