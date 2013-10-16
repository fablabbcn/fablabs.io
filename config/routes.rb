Fablabs::Application.routes.draw do
  resources :users
  resources :labs
  resources :sessions

  get "signout" => "sessions#destroy", :as => "signout"
  get "signin" => "sessions#new", :as => "signin"
  get "signup" => "users#new", :as => "signup"

  namespace :backstage do
    resources :labs
    root to: 'labs#index'
  end

  root to: 'labs#index'
end
