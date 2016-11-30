require 'spec_helper'
describe PagesController do

  describe 'GET #show' do
    it 'not published without current_user' do
      page = FactoryGirl.create(:page, published: false)

      expect {
        get :show, id: page.slug
      }.to raise_error(ActiveRecord::RecordNotFound)
    end

    it 'published' do
      page = FactoryGirl.create(:page, published: true)

      get :show, id: page.slug
      expect(response).to be_success
    end

    it 'not published with non superadmin current_user' do
      user = FactoryGirl.create(:user)
      user.remove_role(:superadmin)
      session[:user_id] = user.id

      page = FactoryGirl.create(:page, published: false)

      expect {
        get :show, id: page.slug
      }.to raise_error(ActiveRecord::RecordNotFound)
    end

    it 'not published with superadmin current_user' do
      user = FactoryGirl.create(:user)
      user.add_role(:superadmin)
      session[:user_id] = user.id

      page = FactoryGirl.create(:page, published: false)

      get :show, id: page.slug
      expect(response).to be_success
    end
  end
end
