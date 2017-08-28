Rails.application.routes.draw do

  get 'reviews/show'

  root to: 'pages#home'

  get '/profile' => 'profiles#profile'



  resources :wishlist, only: [:show, :destroy]

  devise_for :users,
    controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  resources :furnitures, only: [ :index, :show, :destroy ] do
    resources :reviews, only: [ :create ]
  end

end
