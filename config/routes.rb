Rails.application.routes.draw do
  resources :sessions, only: [:create]
  resources :registrations, only: [:create]
  root 'sessions#index'

  delete :logout, to: 'sessions#logout'
  get :logged_in, to: 'sessions#logged_in'

  get '/sessions/index'
  get '/registrations/registration'
  get '/home/home'
  get :logout, to: "sessions#logout"

  post '/sessions/index', to: 'sessions#create'
  post '/', to: 'sessions#create'
  post '/home/home', to: 'sessions#logout'

  post '/registrations/registration', to: 'registrations#create'
end
