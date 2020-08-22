require 'spec_helper'
describe PagesController, type: :controller do

  describe 'GET #show' do
    it 'not published without current_user' do
      page = FactoryBot.create(:page, published: false)

      expect {
        get :show, params: { id: page.slug }
      }.to raise_error(ActiveRecord::RecordNotFound)
    end

    it 'published' do
      page = FactoryBot.create(:page, published: true)

      get :show, params: { id: page.slug }
      expect(response).to be_successful
    end

    it 'not published with non superadmin current_user' do
      user = FactoryBot.create(:user)
      user.remove_role(:superadmin)
      session[:user_id] = user.id

      page = FactoryBot.create(:page, published: false)

      expect {
        get :show, params: { id: page.slug }
      }.to raise_error(ActiveRecord::RecordNotFound)
    end

    it 'not published with superadmin current_user' do
      user = FactoryBot.create(:user)
      user.add_role(:superadmin)
      session[:user_id] = user.id

      page = FactoryBot.create(:page, published: false)

      get :show, params: { id: page.slug }
      expect(response).to be_successful
    end
  end
end
