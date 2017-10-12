Rails.application.routes.draw do
  resources :users
  # signup
  get '/signup' => 'users#new'
  post '/users' => 'users#create'
  # login
  # get    '/login',   to: 'sessions#new'
  # post   '/login',   to: 'sessions#create'
  # delete '/logout',  to: 'sessions#destroy'
end