Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  resources :wishlist, only: [ :index, :show, :create, :update, :destroy ] do
    resources :furnitures_wishlist, only: [ :create, :destroy ] do
      resources :reviews, only: [ :create, :destroy ]
    end
  end

  resources :furnitures, only: [ :index, :show ]
end
