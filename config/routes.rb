Rails.application.routes.draw do


  root to: 'pages#home'

  get '/profile' => 'profiles#profile'
  # resources :wishlist, only: [ :index, :show, :create, :update, :destroy ] do
  # resources :furnitures_wishlist, only: [ :create, :destroy ] do
  # resources :reviews, only: [ :create, :destroy ]
  #   end
  # end
  resources :wishlist, only: [:show, :destroy]
  devise_for :users,
    controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  resources :furnitures, only: [ :index, :show, :destroy ]
end
