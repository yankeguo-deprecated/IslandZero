Rails.application.routes.draw do

  root 'welcome#index'

  get '/home' => 'welcome#home'

  devise_for :users
end
