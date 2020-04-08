Rails.application.routes.draw do

  devise_for :users
  resources :users
  resources :pictures do
    resource :favorites, only: [:create, :destroy]
  end

  root 'pictures#index'
  get '/login', to: 'sessions#new'
end
