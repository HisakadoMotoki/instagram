Rails.application.routes.draw do
  devise_for :users
  resources :pictures do
    member do
      put "like", to: "pictures#upvote"
    end
  end

  root 'pictures#index'
  get '/login', to: 'sessions#new'
end
