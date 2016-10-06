Rails.application.routes.draw do
  root to: "bands#index"
  resources :users, only: [:new, :create, :show]
  resource :session, only: [:new, :create, :destroy]
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
