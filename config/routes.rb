Rails.application.routes.draw do
  resources :lists, only: [:index, :create]
  root 'lists#index'
end
