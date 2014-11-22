Rails.application.routes.draw do

  # Root
  root 'welcome#index'

  # Devise
  devise_for :users

  # Chat
  get 'chat/public'

end
