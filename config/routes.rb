Rails.application.routes.draw do
  root to: 'tasks#index'
  resources :users
  resources :sessions, only: [:new, :create, :destroy]
  resources :tasks do
    collection do
      get "search"
    end
  end
end
