# frozen_string_literal: true

require 'rails_helper'

describe Api::ProfileController, type: :request do
  let!(:user) { FactoryBot.create(:user, workflow_state: :verified, username: 'john') }
  let!(:admin) { FactoryBot.create(:user, workflow_state: :verified, username: 'admin') }

  context 'When not authenticated'
  it 'Does not allow to access a user profile as an anonymous user' do
    get 'http://www.fablabs.dev/api/me'
    expect(response.status).to eq(401)
    expect(response.media_type).to eq(Mime[:json].to_s)
    # expect(response.parsed_body).to eq({error:"Not authorized"})
  end

  context 'When authenticated'

  it 'show profile of superadmin' do
    get_as_admin 'http://www.fablabs.dev/api/me'
    expect(response.status).to eq(200)
    expect(response.media_type).to eq(Mime[:json].to_s)
    expect(json['username']).to eq(admin.username)
  end

  it 'show profile of normal user' do
    get_as_user 'http://www.fablabs.dev/api/me'
    expect(response.status).to eq(200)
    expect(response.media_type).to eq(Mime[:json].to_s)
    expect(json['username']).to eq(user.username)
  end

  it 'do not show for unverified user profile' do
    user.update(workflow_state: :unverified)
    get_as_user 'http://www.fablabs.dev/api/me'
    expect(response.status).to eq(401)
    expect(response.media_type).to eq(Mime[:json].to_s)
    expect(json['username']).to be_nil
  end

  it 'shows profile on legacy /0/users.json endpoint' do
    get_as_user 'http://api.fablabs.dev/0/me.json'
    expect(response.status).to eq(200)
    expect(response.media_type).to eq(Mime[:json].to_s)
    expect(json['username']).to eq(user.username)
  end
end
