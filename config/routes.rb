Rails.application.routes.draw do

  get 'chat/index'

  root 'welcome#index'

  get '/chat' => 'chat#index'

  devise_for :users
end
