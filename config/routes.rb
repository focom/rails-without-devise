# frozen_string_literal: true

Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"

  root 'welcome#index'

  get 'login', to: 'users#login'
  post 'signin', to: 'users#signin'
  get 'logout', to: 'users#logout'

  resources :users

  get 'reset/password', to: 'password_recovery#index'
  post 'reset/password', to: 'password_recovery#send_reset_email'
  get 'set/password/:reset_password_token', to: 'password_recovery#set_password', as: 'set_password'
  patch 'set/password/:reset_password_token', to: 'password_recovery#update_password', as: 'update_password'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
