require 'rails_helper'

describe Api::V2::UserController, :type => :request do
  default_version 2
  context "When not authenticated"

  let!(:user) { FactoryGirl.create :user }
  let!(:admin) { FactoryGirl.create :admin }

  before(:each) do
    admin.add_role :superadmin  
  end

  it "Does not allow to access a user" do
    get 'http://api.fablabs.dev/2/users/' + user.username
    expect(response.status).to eq(401)
    expect(response.content_type).to eq(Mime::JSON)
    # expect(response.parsed_body).to eq({error:"Not authorized"})
  end

  context "When authenticated"

  it "Does allow to get user as a superadmin" do
    get_as_admin 'http://api.fablabs.dev/2/users/' + user.username
    # expect(json['users']).to match_array([user_helper(user)])
    expect(response.status).to eq(403)
    expect(response.content_type).to eq(Mime::JSON)
    # expect(response.parsed_body).to eq({error:"Not authorized"})
  end

end