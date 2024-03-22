Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Defines the root path route ("/")
  root 'blogs#index'

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

  MountableApp::Engine.routes.draw do
    resource :articles, only: :index
  end
end
