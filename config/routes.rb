Rails.application.routes.draw do

  root "snapspots#index"
  get "/welcome", to: "welcome#index", as: "welcome"
  resources :users
  resources :snapspots
  # tags
  get 'tags/:tag', to: 'snapspots#index', as: :tag
  # signup
  get '/signup' => 'users#new'
  post '/users' => 'users#create'
  # login
  get    '/login',   to: 'sessions#new', as:  "login"
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  # Fb authentication
  get "/auth/:provider/callback" => "sessions#create_from_omniauth"
  # likes
  match 'like', to: 'likes#like', via: :post
  match 'unlike', to: 'likes#unlike', via: :delete

end
