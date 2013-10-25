Fablabs::Application.routes.draw do

  %w(about developers).each do |action|
    get action => "static##{action}", as: action
  end

  resources :users, path: 'u'
  resources :sessions
  resources :recoveries

  get "signout" => "sessions#destroy", :as => "signout"
  get "signin" => "sessions#new", :as => "signin"
  get "signup" => "users#new", :as => "signup"
  get "settings" => "users#edit", :as => "settings"

  namespace :backstage do
    resources :labs do
      member do
        patch :approve
        # patch :reject
      end
    end
    root to: 'labs#index'
  end


  # resources :labs, path: '', only: [:show]
  # get 'labs' => 'labs#index'
  # resources :labs, only: [:show, :destroy], path: ''
   #, except: [:show]
  resources :labs, path: '' do
    collection do
      get :map
    end
  end

  root to: 'labs#index'

end
