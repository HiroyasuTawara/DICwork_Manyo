Rails.application.routes.draw do

  root to: 'tasks#index'
  resources :users
  namespace :admin do
    resources :users, only: [:index, :create, :new, :edit, :show, :update, :destroy]
  end
  resources :labels, only: [:index, :create, :new, :edit, :update, :destroy]
  resources :sessions, only: [:new, :create, :destroy]
  resources :tasks do
    collection do
      get "search"
    end
  end

  #エラー用
  get '*not_found' => 'application#routing_error'
  post '*not_found' => 'application#routing_error'
end
