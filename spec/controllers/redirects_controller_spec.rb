require 'spec_helper'
describe RedirectsController, type: :controller do
  describe 'GET #show' do
    it 'redirect to labs by id' do
      lab = FactoryBot.create(:lab)

      get :show, id: lab.id
      path = lab_path(lab)
      expect(response).to redirect_to(path)
    end

    it 'redirect to labs by slug' do
      lab = FactoryBot.create(:lab)
      get :show, id: lab.slug
      path = lab_path(lab)
      expect(response).to redirect_to(path)
    end

    it 'raise routing error' do
      raise_error
      expect{
        get :show, id: 'nothing'
      }.to raise_error(ActionController::RoutingError)
    end
  end

  describe 'GET #projects' do
    it 'redirects to projects.fablabs.io' do
      get :projects
      expect(response).to redirect_to('https://projects.fablabs.io')
    end
  end
    
end
