Rails.application.routes.draw do

  resources :posts

  resources :topics

  # Root
  root 'welcome#index'

  # Devise
  devise_for :users

  # Chat
  get 'chat/public'

end
