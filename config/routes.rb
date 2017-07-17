Rails.application.routes.draw do
  root to: "links#index"

  # get '/signup', to: "users#new"
  get '/authenticate', to: "authenticate#index"
  resources :users, only: [:create]


  resources :links, only: [:index]

  namespace :api do
    namespace :v1 do
      resources :links, only: [:update]
    end
  end
end
