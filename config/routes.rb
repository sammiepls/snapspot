Rails.application.routes.draw do
  get 'welcome/index'

  root "users#new"
  resources :users
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
