Rails.application.routes.draw do
  
  root 'pictures#index'
  devise_for :users
  get '/login', to: 'sessions#new'
#  get '/users/:id/follower', to: 'users#follower'
  
  resources :pictures do
    resource :favorites, only: [:create, :destroy]
  end

  resources :users do
    resource :relationships, only: [:create, :destroy]
    get :follows, on: :member
    get :followers, on: :member
  end


end
