Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  get '/pages/:page' => 'pages#show'

  root 'pages#show', page: 'home'

  devise_for :users

  resources :users, only: :show

  resources :user_programs do
    member do
      put 'complete'
    end
  end
end
