Fablabs::Application.routes.draw do
  resources :labs
  root to: 'labs#index'
end
