# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users,
    controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  get 'comments/create'
  get 'comments/destroy'
  root 'pictures#index'
  get '/login', to: 'sessions#new'
  get '/search', to: 'pictures#search'
  resources :notifications, only: :index

  resources :pictures do
    resource :favorites, only: %i[create destroy]
    resources :comments, only: %i[create destroy]
  end

  resources :users do
    resource :relationships, only: %i[create destroy]
    get :follows, on: :member
    get :followers, on: :member
    resource :favorites, only: %i[create destroy]
    get :favorites, on: :member
  end
end
