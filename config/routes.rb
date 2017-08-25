Rails.application.routes.draw do


  root to: 'pages#home'

  get '/profile' => 'profiles#profile'

  resources :wishlist, only: [:show, :destroy] do
    resources :wishlist_items, only: [:create]
  end
  devise_for :users,
    controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  resources :furnitures, only: [ :index, :show, :destroy ]
end
