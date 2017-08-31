Rails.application.routes.draw do

  get 'charges/new'

  get 'charges/create'

  get 'reviews/show'

  root to: 'pages#home'

  get '/profile' => 'profiles#profile'

  post 'wishlists/add_item'

  post 'wishlists/add_and_create'

  get 'wishlists/furnitures_wishlists/show'

  resources :wishlists, only: [:show, :create, :destroy] do
    resources :guest_wishlists, path: :users, module: :wishlists
  end

  resources :donations, only: [:show, :create] do
    resources :payments, only: [:new, :create]
  end

  devise_for :users,
    controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  resources :furnitures, only: [ :index, :show, :destroy ]

  resources :reviews, only: [ :create ]

end
