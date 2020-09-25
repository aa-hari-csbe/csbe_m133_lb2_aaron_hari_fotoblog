Rails.application.routes.draw do
  resources :sessions, only: [:create, :logout]
  resources :registrations, only: [:create]
  root 'sessions#index'

  #delete :logout, to: 'sessions#logout'
  get :logged_in, to: 'sessions#logged_in'

  get '/sessions/index'
  get '/registrations/registration'
  get '/home/home'
  get '/logout', to: "sessions#logout"
  get '/home/profile'



  get '/home/home/:picture_id', to: 'home#set_picture_id'

  post '/sessions/index', to: 'sessions#create'
  post '/', to: 'sessions#create'
  #post '/home/home', to: 'sessions#logout'
  post '/home/home/', to: 'home#create_comment'

  post '/registrations/registration', to: 'registrations#create'

  post '/home/profile', to: 'home#update'
end
