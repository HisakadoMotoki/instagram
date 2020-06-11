Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  get 'comments/create'
  get 'comments/destroy'
  root 'pictures#index'
  get '/login', to: 'sessions#new'
  get '/search', to: 'pictures#search'
#  get '/users/:id/follower', to: 'users#follower'
  resources :notifications, only: :index

  resources :pictures do
    resource :favorites, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
  end

  resources :users do
    resource :relationships, only: [:create, :destroy]
    get :follows, on: :member
    get :followers, on: :member
    resource :favorites, only: [:create, :destroy]
    get :favorites, on: :member
  end


end
