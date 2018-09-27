Rails.application.routes.draw do
  resources :tasks do
    resources :comments, only: [:create]
  end

  root to: 'tasks#index'
end
