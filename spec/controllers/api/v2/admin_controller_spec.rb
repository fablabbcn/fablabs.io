describe Api::V2::AdminController, :type => :api do
  context 'When not authenticated'

  it 'Does not allow to list users' do
    get :users
    expect(response).to raise_error
  end


end
