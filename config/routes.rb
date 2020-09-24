Rails.application.routes.draw do
  resources :sessions, only: [:create]
  resources :registrations, only: [:create]
  root to: "fotoblog#index"

  delete :logout, to: "sessions#logout"
  get :logged_in, to: "sessions#logged_in"
end
