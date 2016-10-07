Rails.application.routes.draw do
  root to: "bands#index"
  resources :users, only: [:new, :create, :show, :index, :destroy]
  resource :session, only: [:new, :create, :destroy]

  get 'activate/:token', to: 'users#activate', as: 'activate'
  get 'make_admin/:id', to: 'users#make_admin', as: 'make_admin'
  get 'search', to: 'application#search', as: 'search'

  resources :bands
  resources :bands do
    resources :albums, only: [:new, :create]
  end
  resources :albums, only: [:edit, :show, :update, :destroy]
  resources :albums do
    resources :tracks, only: [:new, :create]
  end
  resources :tracks, only: [:edit, :show, :update, :destroy]
  resources :comments, only: [:create, :destroy]
end
