Rails.application.routes.draw do
  resources :sessions, only: [:crate]
  root to: "fotoblog#index"
end
