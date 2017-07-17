Rails.application.routes.draw do
  root to: "links#index"

  # get '/signup', to: "users#new"
  get '/authenticate', to: "authenticate#index"
  resources :users, only: [:create]

  post '/sessions', to: 'sessions#create'
  get '/login', to: 'sessions#new'
  get '/signup', to: 'users#new'
  get '/logout', to: 'sessions#destroy'\
  

  resources :links, only: [:index, :create]

  namespace :api do
    namespace :v1 do
      resources :links, only: [:update]
    end
  end
end
