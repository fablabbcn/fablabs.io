Fablabs::Application.routes.draw do
  resources :users
  resources :labs
  resources :sessions

  get "signout" => "sessions#destroy", :as => "signout"
  get "signin" => "sessions#new", :as => "signin"
  get "signup" => "users#new", :as => "signup"

  root to: 'labs#index'
end
