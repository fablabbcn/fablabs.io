Fablabs::Application.routes.draw do

  resources :discussions

  resources :featured_images

  get "verify_email(/:id)", to: "users#verify_email", as: "verify_email"

  %w(about developers choose_locale).each do |action|
    get action => "static##{action}", as: action
  end

  resources :users, path: 'u'
  resources :tools

  resources :sessions
  resources :recoveries do
    collection do
      get :check_inbox
    end
  end

  get "signout" => "sessions#destroy", :as => "signout"
  get "signin" => "sessions#new", :as => "signin"
  get "signup" => "users#new", :as => "signup"
  get "settings" => "users#edit", :as => "settings"

  get "resend_verification_email" => "users#resend_verification_email"

  namespace :backstage do
    resources :users
    resources :labs do
      member do
        patch :approve
        # patch :reject
      end
    end
    root to: 'labs#index'
  end


  # resources :labs, path: '', only: [:show]

  # resources :labs, only: [:show, :destroy], path: ''
   #, except: [:show]
  get 'labs' => 'labs#index'
  post 'labs' => 'labs#create'
  resources :labs, path: '', except: :index do
    resources :role_applications
    resources :employees
    resources :discussions
    member do
      get :manage_admins
    end
    collection do
      get :map
    end
  end


  root to: 'static#home'

end
