require 'spec_helper'
describe RedirectsController do
  describe 'GET #show' do
    it 'redirect to labs by id' do
      lab = FactoryGirl.create(:lab)

      get :show, id: lab.id
      expect(response).to redirect_to(lab_path(lab))
    end

    it 'redirect to labs by slug' do
      lab = FactoryGirl.create(:lab)

      get :show, id: lab.slug
      expect(response).to redirect_to(lab_path(lab))
    end

    it 'raise routing error' do
      raise_error
      expect{
        get :show, id: 'nothing'
      }.to raise_error(ActionController::RoutingError)
    end
  end
end
