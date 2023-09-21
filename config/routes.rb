require 'sidekiq/web'

Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  authenticate :admin_user do
    mount Sidekiq::Web => 'admin/sidekiq'
  end

  get '/pages/:page' => 'pages#show'

  root 'children#index'

  devise_for :users

  resources :children do
    resources :contacts, only: %i[create destroy]

    member do
      get 'passport'
      get 'interactive_passport'
    end
  end

  resources :child_programs do
    member do
      put 'complete'
    end
  end
end
