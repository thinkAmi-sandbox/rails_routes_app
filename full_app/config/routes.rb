Rails.application.routes.draw do
  resources :shops, only: [:index, :create]
end
