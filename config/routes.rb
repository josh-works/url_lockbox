Rails.application.routes.draw do
  root to: "sessions#create"

  get '/signup', to: "users#new"
  

  resources :links, only: [:index]

  namespace :api do
    namespace :v1 do
      resources :links, only: [:update]
    end
  end
end
