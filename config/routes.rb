Fablabs::Application.routes.draw do
  resources :pages

  resources :events

  use_doorkeeper
  require 'sidekiq/web'
  require "admin_constraint"
  mount Sidekiq::Web, at: '/sidekiq', constraints: AdminConstraint.new

  get "signout" => "sessions#destroy", :as => "signout"
  get "signin" => "sessions#new", :as => "signin"
  get '/robots.txt' => 'robots#robots', :format => :txt

  resources :sessions


  constraints subdomain: 'www' do
    # resources :discussions
    get "activity" => "activities#index", :as => "activity"
    resources :featured_images

    get "verify_email(/:id)", to: "users#verify_email", as: "verify_email"

    %w(about choose_locale country_guess).each do |action|
      get action => "static##{action}", as: action
    end

    resources :users
    resources :chat_messages
    get 'chat' => 'chat_messages#index', as: 'chat'

    %w(books machines).each do |thing|
      resources thing do
        # resources :discussions
      end
    end

    resources :brands

    resources :comments, only: [:create]

    resources :recoveries do
      collection do
        get :check_inbox
      end
    end

    get "signup" => "users#new", :as => "signup"
    get "settings" => "users#edit", :as => "settings"

    get "resend_verification_email" => "users#resend_verification_email"

    namespace :backstage do
      resources :users
      resources :employees, only: :index
      resources :labs do
        member do
          patch :approve
          patch :reject
          patch :remove
        end
      end
      root to: 'labs#index'
    end

    resources :employees do
      member do
        patch :approve
      end
    end

    # resources :labs, path: '', only: [:show]

    # resources :labs, only: [:show, :destroy], path: ''
     #, except: [:show]
    get 'labs' => 'labs#index'
    post 'labs' => 'labs#create'
    resources :labs, path: '', except: :index do
      resources :admin_applications
      resources :role_applications
      resources :employees
      get 'mapdata', on: :collection
      # resources :discussions
      resources :admins do
        collection do
          delete '/' => 'admins#destroy'
        end
      end
      member do
        get :manage_admins
      end
      collection do
        get :map
      end
    end

    root to: 'static#home'

  end

  constraints subdomain: 'api' do
    get '/' => 'static#api'
    namespace :api, path: '' do
      namespace :v0 do
        get 'me' => 'users#me'
        resources :labs do
          get :map, on: :collection
        end
      end
    end
  end

  # constraints subdomain: 'api' do
  #   use_doorkeeper
  #   get '/' => 'static#api'
  #   api versions: 1, module: "api/v1" do
  #     get 'me' => 'users#show'
  #     resources :labs, only: [:index]
  #   end
  # end

end