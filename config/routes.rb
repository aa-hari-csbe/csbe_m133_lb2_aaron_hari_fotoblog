# All the available routs are defined here.
Rails.application.routes.draw do

  # Defines the available resources.
  resources :sessions, only: [:create, :logout]
  resources :registrations, only: [:create]
  # Defines the default rout.
  root 'sessions#index'

  get :logged_in, to: 'sessions#logged_in'

  get '/sessions/index'
  get '/registrations/registration'
  get '/home/home'
  get '/logout', to: "sessions#logout"
  get '/home/profile', to: 'home#profile'

  get '/home/home/:picture_id', to: 'home#like', as: 'like_picture'

  post '/sessions/index', to: 'sessions#create'
  post '/', to: 'sessions#create'

  post '/home/home', to: 'home#create'

  post '/registrations/registration', to: 'registrations#create'

  patch '/home/profile', to: 'home#update', as: 'update_user'
  delete '/home/profile', to: 'home#destroy', as: 'delete_user'

end
