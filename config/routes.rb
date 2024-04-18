Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  mount MountableApp::Engine => '/mountable_app'
  mount MountableSecondApp::Engine => '/mountable_second_app'

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Defines the root path route ("/")
  root 'blogs#index'

  # HTTP Verb Constraints
  # multiple HTTP method
  # https://guides.rubyonrails.org/routing.html#http-verb-constraints
  match '/multiple_match', to: 'multiple#call', via: [:get, :post]

  # Resource Routing
  # https://guides.rubyonrails.org/routing.html#crud-verbs-and-actions
  resources :apples

  # Singular Resources
  # https://guides.rubyonrails.org/routing.html#singular-resources
  resource :icon

  # Nested Resources
  # https://guides.rubyonrails.org/routing.html#nested-resources
  resources :blogs do
    resources :posts, module: :blogs do
      resources :comments, module: :posts
    end

    # Controller Namespaces and Routing
    # https://guides.rubyonrails.org/routing.html#controller-namespaces-and-routing
    namespace :forum, module: :blogs do
      resources :categories, only: :index, module: :forums
    end
  end

  # Shallow Nesting
  # https://guides.rubyonrails.org/routing.html#shallow-nesting
  # 4 actions edit, show, update, and destroy with id shorten the URL pattern
  # (parents disappear from the URL).
  resources :parents, shallow: true do
    resources :children
  end

  # Routing Concerns
  # https://guides.rubyonrails.org/routing.html#routing-concerns
  concern :image_attachable do
    resources :images, only: :index
  end
  resources :news, concerns: :image_attachable, only: :index

  # Adding Member Routes
  # https://guides.rubyonrails.org/routing.html#adding-member-routes
  resources :reports, only: :index do
    member do
      get 'preview'
    end
  end

  # Adding Collection Routes
  # https://guides.rubyonrails.org/routing.html#adding-collection-routes
  resources :movies, only: :index do
    collection do
      get 'search'
    end
  end


  # Adding Routes for Additional New Actions
  # https://guides.rubyonrails.org/routing.html#adding-routes-for-additional-new-actions
  resources :assignments, only: :index do
    get 'draft', on: :new
  end


  # Redirection
  # https://guides.rubyonrails.org/routing.html#redirection
  get '/redirect', to: redirect('/blogs')


  # Segment Constraints
  # https://guides.rubyonrails.org/routing.html#segment-constraints
  get 'photos/:id', to: 'photos#show', constraints: { id: /[A-Z]\d{5}/ }
  get 'videos/:id', to: 'videos#show', id: /[A-Z]\d{5}/

  # inline route
  # https://guides.rubyonrails.org/routing.html#routing-to-rack-applications
  get '/inline', to: ->(env) { [204, {}, ['']] }


  # Routing to Rack Applications
  # https://guides.rubyonrails.org/routing.html#routing-to-rack-applications
  match '/rack_app', to: HelloRackApp.new, via: :all


  # Direct routes
  # https://guides.rubyonrails.org/routing.html#direct-routes
  # => Not visible in rails routes
  direct :hatena_blog do
    'https://thinkami.hatenablog.com/'
  end


  # Unknown (Not Resourceful)
  # https://guides.rubyonrails.org/routing.html#non-resourceful-routes
  get '/unknown', to: 'unknown#show'
  get '/videos/unknown', to: 'videos#unknown'


  # Rails Engine
  # https://guides.rubyonrails.org/engines.html#routes
  MountableApp::Engine.routes.draw do
    resources :articles, only: [:index, :create]
    get '/main_root_redirect', to: redirect('/')
  end

  MountableSecondApp::Engine.routes.draw do
    resources :reviews, only: [:index, :create]
  end
end
