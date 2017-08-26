Rails.application.routes.draw do


  get 'reviews/show'

  root to: 'pages#home'

  get '/profile' => 'profiles#profile'

  resources :wishlist, only: [:show, :destroy] do
    resources :wishlist_items, only: [:create]
  end
  devise_for :users,
    controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  resources :furnitures, only: [ :index, :show, :destroy ]

  if Rails.env.production?
    get '404', to: 'application#page_not_found'
  end
end
