Rails.application.routes.draw do
  resources :users
  root to: 'tasks#index'
  resources :tasks do
    collection do
      get "search"
    end
  end
end
