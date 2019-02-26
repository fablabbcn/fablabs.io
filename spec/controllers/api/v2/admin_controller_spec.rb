# frozen_string_literal: true

require 'rails_helper'

describe Api::V2::AdminController, type: :request do
  default_version 2

  describe 'GET users#index' do
    context 'When not authenticated'

    it 'Does not allow to list users' do
      get 'http://api.fablabs.dev/2/users'
      expect(response.status).to eq(401)
      expect(response.content_type).to eq(Mime::JSON)
      # expect(response.parsed_body).to eq({error:'Not authorized'})
    end

    context 'When authenticated'
    let!(:user) { FactoryBot.create :user }

    it 'Does not allow to list users as normal user' do
      get_as_user 'http://api.fablabs.dev/2/users'
      # expect(json['users']).to match_array([user_helper(user)])
      expect(response.status).to eq(403)
      expect(response.content_type).to eq(Mime::JSON)
      # expect(response.parsed_body).to eq({error:'Not authorized'})
    end

    context 'When authenticated as admin'

    it 'Does allow to list users as an admin' do
      user.add_role :superadmin
      get_as_user 'http://api.fablabs.dev/2/users'
      # expect(json['users']).to match_array([user_helper(user)])
      expect(response.status).to eq(200)
      expect(response.content_type).to eq(Mime::JSON)
      # expect(response.parsed_body).to eq({error:'Not authorized'})
    end
  end

  describe 'POST users#create_user' do
    context 'When not authenticated'
    it 'Does not allow to create a user' do
      post 'http://api.fablabs.dev/2/users'
      expect(response.status).to eq(401)
      expect(response.content_type).to eq(Mime::JSON)
    end

    context 'When not authenticated as admin'
    let!(:user) { FactoryBot.create :user }

    it 'Does not allow to create a user' do
      post_as_user 'http://api.fablabs.dev/2/users'
      expect(response.status).to eq(403)
      expect(response.content_type).to eq(Mime::JSON)
    end

    context 'When authenticated as admin'
    it 'Does allow to create a user' do
      user.add_role :superadmin
      user_dict = {
        'first_name': 'Some',
        'last_name': 'User',
        'username': 'some.user',
        'email': 'some.user@example.com',
        'password': 'somepassword',
        'password_confirmation': 'somepassword',
        'agree_policy_terms': true
      }
      post_as_user 'http://api.fablabs.dev/2/users', data: user_dict
      expect(response.status).to eq(200)
      expect(response.content_type).to eq(Mime::JSON)

      result = JSON.parse(response.body)
      attrs = result['data']['attributes']

      expect(attrs['first_name']).to eq(user_dict[:first_name])
      expect(attrs['last_name']).to eq(user_dict[:last_name])
      expect(attrs['username']).to eq(user_dict[:username])
      expect(attrs['email']).to eq(user_dict[:email])
      expect(attrs['avatar_url']).to be_truthy
      expect(attrs['id']).not_to be_falsy
    end
  end
end
