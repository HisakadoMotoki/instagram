Rails.application.routes.draw do
  devise_for :users
  resources :pictures

  root 'pictures#index'
  get '/login', to: 'sessions#new'
end
