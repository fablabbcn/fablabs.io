require 'spec_helper'
describe RedirectsController do
  describe 'GET #show' do
    it 'redirect to labs by id' do
      lab = FactoryGirl.create(:lab)

      get :show, id: lab.id
      path = lab_path(lab)
      expect(response).to redirect_to(path)
    end

    it 'redirect to labs by slug' do
      lab = FactoryGirl.create(:lab)
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
end
