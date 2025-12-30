# frozen_string_literal: true

require 'rails_helper'

describe Api::V2::AdminController, type: :request do
  describe 'GET users#index' do
    context 'When not authenticated'

    it 'Does not allow to list users as anonymous' do
      get 'http://api.fablabs.dev/2/users'
      expect(response.status).to eq(401)
      expect(response.media_type).to eq(Mime[:json].to_s)
      # expect(response.parsed_body).to eq({error:'Not authorized'})
    end

    context 'When authenticated'
    let!(:user) { FactoryBot.create :user }

    it 'Does not allow to list users as regular user' do
      get_as_user 'http://api.fablabs.dev/2/users'
      # expect(json['users']).to match_array([user_helper(user)])
      expect(response.status).to eq(403)
      expect(response.media_type).to eq(Mime[:json].to_s)
      # expect(response.parsed_body).to eq({error:'Not authorized'})
    end

    context 'When authenticated as admin'

    it 'Does allow to list users as an admin' do
      user.add_role :superadmin
      get_as_user 'http://api.fablabs.dev/2/users'
      # expect(json['users']).to match_array([user_helper(user)])
      expect(response.status).to eq(200)
      expect(response.media_type).to eq(Mime[:json].to_s)
      # expect(response.parsed_body).to eq({error:'Not authorized'})
    end
  end

  describe 'GET users#get_user with dot in username' do
    the_username = 'first.second'
    let!(:user) { FactoryBot.create :user, username: the_username }

    it 'returns a single user' do
      user.add_role :superadmin
      username_slug = the_username.gsub('.', '-')
      get_as_user "http://api.fablabs.dev/2/users/#{username_slug}"
      expect(response.status).to eq(200)
      expect(response.media_type).to eq(Mime[:json].to_s)
      expect(JSON.parse(response.body)['data']['attributes']['username']).to eq(the_username)
    end
  end

  describe 'POST users#create_user' do
    context 'When not authenticated'
    it 'Does not allow to create a user as anonymous' do
      post 'http://api.fablabs.dev/2/users'
      expect(response.status).to eq(401)
      expect(response.media_type).to eq(Mime[:json].to_s)
    end

    context 'When not authenticated as admin'
    let!(:user) { FactoryBot.create :user }

    it 'Does not allow to create a user as a regular user' do
      post_as_user 'http://api.fablabs.dev/2/users'
      expect(response.status).to eq(403)
      expect(response.media_type).to eq(Mime[:json].to_s)
    end

    context 'When authenticated as admin'
    it 'Does allow to create a user as admin' do
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
      expect(response.media_type).to eq(Mime[:json].to_s)

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

  describe 'POST users#search_users' do
    context 'When not authenticated'
    let!(:user) { FactoryBot.create :user }

    it 'Does not allow to search users as anonymous' do
      post 'http://api.fablabs.dev/2/users/search', params: { data: { 'username' => 'johnrees', 'email': 'test@example.com' } }
      expect(response.status).to eq(401)
      expect(response.media_type).to eq(Mime[:json].to_s)
    end

    context 'When not authenticated as admin'
    it 'Does not allow to search users as regular user' do
      post_as_user 'http://api.fablabs.dev/2/users/search', data: { 'username' => 'johnrees', 'email': 'test@example.com' }
      expect(response.status).to eq(403)
      expect(response.media_type).to eq(Mime[:json].to_s)
    end

    context 'When authenticated as admin'
    let!(:user2) { FactoryBot.create :user }
    let!(:user3) { FactoryBot.create :user, username: 'strangematch' }
    it 'Does not find the wrong users as an admin' do
      user.add_role :superadmin
      post_as_user 'http://api.fablabs.dev/2/users/search', data: { 'username' => 'blabla'}

      expect(response.status).to eq(200)
      expect(response.media_type).to eq(Mime[:json].to_s)
      result = JSON.parse(response.body)
      items = result['data']
      meta = result['meta']
      expect(items.length).to eq(0)
    end
    it 'Does allow to search users as an admin, providing a username' do
      user.add_role :superadmin
      post_as_user 'http://api.fablabs.dev/2/users/search', data: { 'username' => user3.username }
      expect(response.status).to eq(200)
      expect(response.media_type).to eq(Mime[:json].to_s)
      result = JSON.parse(response.body)
      items = result['data']
      meta = result['meta']
      expect(items.length).to eq(1)
      expect(items[0]['attributes']['username']).to eq(user3.username)
      expect(meta['total-pages']).to eq(1)
    end
    it 'Does allow to search users as an admin, providing an email' do
      user.add_role :superadmin
      post_as_user 'http://api.fablabs.dev/2/users/search', data: { 'email' => user3.email}
      expect(response.status).to eq(200)
      expect(response.media_type).to eq(Mime[:json].to_s)
      result = JSON.parse(response.body)
      items = result['data']
      meta = result['meta']
      expect(items.length).to eq(1)
      expect(items[0]['attributes']['username']).to eq(user3.username)
      expect(meta['total-pages']).to eq(1)
    end
  end
end
