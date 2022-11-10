Rails.application.routes.draw do
  root to: 'tasks#index'
  resources :users, only: [:create, :new, :edit, :show, :update, :destroy]
  namespace :admin do
    resources :users, only: [:index, :create, :new, :edit, :show, :update, :destroy]
  end
  resources :sessions, only: [:new, :create, :destroy]
  resources :tasks do
    collection do
      get "search"
    end
  end
end
