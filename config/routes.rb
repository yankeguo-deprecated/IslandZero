require 'sidekiq/web'

Rails.application.routes.draw do
  # Sidekiq Web UI
  authenticate :user, lambda { |u| u.is_super_admin } do
    mount Sidekiq::Web => '/sidekiq'
  end

  # Root
  root 'welcome#index'

  get  'timeline' => 'welcome#timeline'

  # Devise
  devise_for :users , controllers: {
    passwords:           "users/passwords",
    confirmations:       "users/confirmations",
    registrations:       "users/registrations",
    omniauth_callbacks:  "users/omniauth_callbacks"
  }

  # Resource
  resources :users,  only:   [:index, :update]
  resources :posts,  except: [:index]
  resources :topics, except: [:destroy]
  resources :messages
  resources :starred_topics, only: [:index, :destroy, :create]

  # Search
  post "search" => "search#search"

end
