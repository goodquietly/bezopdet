Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  root 'users#show'

  devise_for :users

  resources :users, only: :show
end
