Rails.application.routes.draw do

  root 'home#index'

  get '/home' => 'home#home'

  devise_for :users
end
