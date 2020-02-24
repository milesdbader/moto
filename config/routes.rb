Rails.application.routes.draw do
  get 'profiles/index'
  get 'profiles/show'
  get 'votes/create'
  get 'votes/index'
  get 'votes/new'
  get 'players/create'
  get 'players/edit'
  get 'players/update'
  get 'challenges/new'
  get 'challenges/show'
  get 'challenges/create'
  get 'challenges/accepted'
  get 'challenges/destroy'
  devise_for :users
  root to: 'challenges#index'
  resources :challenges, except: [:update, :edit] do
    resources :votes, only: [:create, :new, :index]
  end
  put 'challenges', to: "challenges#accepted?", as: :accept

  resources :players, only: [:create, :edit, :update]
  resources :profile, only: [:index, :show]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
