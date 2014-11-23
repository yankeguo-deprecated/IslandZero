Rails.application.routes.draw do

  # Root
  root 'welcome#index'

  # Devise
  devise_for :users

  resources :posts

  resources :topics

end
