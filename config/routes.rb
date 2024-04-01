Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  mount MountableApp::Engine => '/mountable_app'
  mount MountableSecondApp::Engine => '/mountable_second_app'

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Defines the root path route ("/")
  root 'blogs#index'

  # multiple HTTP method
  match '/multiple_match', to: 'multiple#call', via: [:get, :post]

  resources :blogs do
    resources :posts, module: :blogs do
      resources :comments, module: :posts
    end
    namespace :forum, module: :blogs do
      resources :categories, only: :index, module: :forums
    end
  end

  get '/redirect', to: redirect('/blogs')

  get 'photos/:id', to: 'photos#show', constraints: { id: /[A-Z]\d{5}/ }
  get 'videos/:id', to: 'videos#show', id: /[A-Z]\d{5}/

  # inline route
  get '/inline', to: ->(env) { [204, {}, ['']] }

  # Rack app
  match '/rack_app', to: HelloRackApp.new, via: :all

  # Unknown
  get '/unknown', to: 'unknown#show'
  get '/videos/unknown', to: 'videos#unknown'

  MountableApp::Engine.routes.draw do
    resources :articles, only: [:index, :create]
    get '/main_root_redirect', to: redirect('/')
  end

  MountableSecondApp::Engine.routes.draw do
    resources :reviews, only: [:index, :create]
  end
end
