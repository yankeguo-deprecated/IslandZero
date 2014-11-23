require 'sidekiq/web'

Rails.application.routes.draw do
  # Sidekiq Web UI
  mount Sidekiq::Web => '/sidekiq'

  # Root
  root 'welcome#index'

  # Devise
  devise_for :users

  resources :posts
  resources :topics

end
