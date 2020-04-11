Rails.application.routes.draw do
  
  get 'comments/create'
  get 'comments/destroy'
  root 'pictures#index'
  devise_for :users
  get '/login', to: 'sessions#new'
#  get '/users/:id/follower', to: 'users#follower'
  
  resources :pictures do
    resource :favorites, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
  end

  resources :users do
    resource :relationships, only: [:create, :destroy]
    get :follows, on: :member
    get :followers, on: :member
  end


end
