Rails.application.routes.draw do

  root "welcome#index"
  resources :users
  resources :snapspots
  get "/users/:id/snapspots" => "snapspots#user_snapspots", as: "user_snapspots"

  # signup
  get '/signup' => 'users#new'
  post '/users' => 'users#create'
  # login
  get    '/login',   to: 'sessions#new', as:  "login"
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  # Fb authentication
  get "/auth/:provider/callback" => "sessions#create_from_omniauth"

end
