Rails.application.routes.draw do

  get 'reviews/show'

  root to: 'pages#home'

  get '/profile' => 'profiles#profile'

  post 'wishlists/add_item'

  resources :wishlists, only: [:show, :create, :destroy]

  devise_for :users,
    controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  resources :furnitures, only: [ :index, :show, :destroy ]

end
