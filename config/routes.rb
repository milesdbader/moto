Rails.application.routes.draw do
  devise_for :users
  root to: 'challenges#index'
  resources :challenges, except: [:update, :edit] do
    resources :votes, only: [:create, :new, :index]
  get 'serve', to: "challenges#serve", as: :serve
  end
  patch 'challenges/:id', to: "challenges#accepted", as: :accept
  get 'take_user', to: "challenges#take_user", as: :take_user
  post 'randomizer', to: "challenges#randomizer", as: :randomizer
  post 'reciper', to: "challenges#reciper", as: :reciper
  resources :players, only: [:create, :edit, :update]
  resources :profiles, only: [:show]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
