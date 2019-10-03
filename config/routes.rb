Rails.application.routes.draw do
  get 'version', to: 'static#version'
  get "discourse/sso"
  get "discuss" => 'discourse#embed'
  resources :pages, only: [:show]
  require 'sidekiq/web'
  require "admin_constraint"
  mount Sidekiq::Web, at: '/sidekiq', constraints: AdminConstraint.new

  get "signout" => "sessions#destroy", :as => "signout"
  get "signin" => "sessions#new", :as => "signin"
  get '/robots.txt' => 'robots#robots', :format => :txt

  resources :sessions

  #constraints subdomain: 'www' do
  constraints(WWWSubdomain) do
    # resources :discussions
    get "activity" => "activities#index", :as => "activity"
    resources :featured_images
    resources :organizations, only: [:index, :show, :new, :create, :edit, :update] do
      resources :lab_organizations, controller: 'organizations/lab_organizations' do
        member do
          post :accept
        end
      end
    end

    # resources :events

    get "verify_email(/:id)", to: "users#verify_email", as: "verify_email"

    %w(tos privacy-policy cookie-policy about choose_locale country_guess).each do |action|
      underscored = action.underscore
      get action => "static##{underscored}", as: underscored
    end

    resources :users
    resources :machines

    resources :brands

    resources :comments, only: [:create]

    resources :recoveries do
      collection do
        get :check_inbox
      end
    end

    get "signup" => "users#new", :as => "signup"
    get "settings" => "users#edit", :as => "settings"
    get "change_password" => "users#change_password", :as => "password"
    patch "update_password" => "users#update_password"

    get "resend_verification_email" => "users#resend_verification_email"

    namespace :backstage do
      get "users/list" => "users#list"
      resources :users do
        resources :roles, controller: 'users/roles', only: [:index, :new, :create, :destroy]
      end
      resources :employees, only: :index
      resources :pages, expect: [:show]
      resources :organizations, only: [:index]
      resources :my_labs, only: [:index]
      resources :my_projects, only: [:index]
      resources :projects, only: [:index, :destroy] do
        patch :visible
        patch :hidden
      end
      resources :to_approve_labs, only: [:index]
      resources :labs do
        member do
          patch :approve
          patch :reject
          patch :remove
          patch :referee_approves
          patch :referee_rejects
          get   :request_more_info, to: 'labs#edit_request_more_info'
          patch :request_more_info
          patch :referee_requests_admin_approval
          patch :admin_approves
          patch :admin_rejects
          patch :add_more_info
        end
      end
      root to: 'labs#index'
    end

    resources :employees do
      member do
        patch :approve
      end
    end

    get 'events' => 'events#main_index', as: 'events'
    
    resources :search, only: [:index]
    
    # Disabling projects routes now implemented in projects.fablabs.io
    # resources :projects do
    #   collection do
    #     get '/tags', action: :search
    #     get '/lab/:slug', action: :search
    #     get :map
    #     get :embed
    #   end
    #   get 'mapdata', on: :collection
    #   resources :steps do
    #     resources :links
    #   end
    # end


    
    resources :referee_approval_processes, only: [:destroy]
    resources :contributions, only: [:destroy]
    resources :collaborations, only: [:destroy]
    resources :documents, only: [:destroy]
    resources :facilities, only: [:destroy]

    resources :users do
      resources :favourites, only: [:create, :destroy]
      resources :grades, only: [:create, :destroy]
    end

    get "/labs/docs/:page" => "labs#docs"
    resources :labs do
      resources :events
      resources :admin_applications
      resources :role_applications
      resources :employees
      resources :academics

      get 'mapdata', on: :collection
      # resources :discussions
      member do
        get :manage_admins
      end
      collection do
        get :map
        get :embed
        get :list
      end
    end

    use_doorkeeper do
      controllers :applications => 'oauth/applications'
    end


    root to: 'static#home'

  end

  constraints(ApiSubdomain) do

    use_doorkeeper do
      controllers :applications => 'oauth/applications'
    end



    get '/' => 'static#api'
    # root to: ''static#api'
    api version: 0, module: "api/v0", as: "api_v0" do
        get 'me' => 'users#me'
        get 'users' => 'users#search'
        get 'labs/search' => 'labs#search'

        get 'search/all' => 'search#all'
        get 'search/labs' => 'search#labs'
        get 'search/projects' => 'search#projects'
        get 'search/machines' => 'search#machines'

        resources :coupons do
          get "redeem", on: :member
        end
        resources :labs do
          get :map, on: :collection
        end
        resources :projects do
          get :map, on: :collection
        end
    end
    api version: 1, module: "api/v1", as: "api_v1" do
      get 'users' => 'users#search'

    end
    api version: 2, module: "api/v2", as: "api_v2" do

      # admin routes
      get 'users' => 'admin#list_users'
      post 'users' => 'admin#create_user'
      # user profile
      get 'users/me' => 'user#me'
      post 'users/me' => 'user#update_user'
      post 'users/search' => 'admin#search_users'
      get 'users/:username' => 'admin#get_user'

      # labs
      get 'labs' => 'labs#index'
      post 'labs' => 'labs#create'
      get 'labs/search' => 'labs#search'
      get 'labs/map' => 'labs#map'
      get 'labs/:id' => 'labs#show'
      put 'labs/:id' => 'labs#update'
      get 'labs/:id/relationships/machines' => 'labs#get_lab_machines_by_id'
      post 'labs/:id/relationships/machines' => 'labs#add_lab_machine_by_id'
 
      # projects
      get 'projects' => 'projects#index'
      post 'projects' => 'projects#create'
      get 'projects/search' => 'projects#search_projects'
      get 'projects/:id' => 'projects#show'
      put 'projects/:id' => 'projects#update'

      # organizations
      get 'organizations' => 'organizations#index'
      post 'organizations' => 'organizations#create'
      get 'organizations/:id' => 'organizations#show'
      put 'organizations/:id' => 'organizations#/update'

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

  get ':id' => 'redirects#show'

  get 'projects' => 'redirects#projects'
end
