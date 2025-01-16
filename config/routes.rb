# frozen_string_literal: true

Rails.application.routes.draw do
  root 'web/bulletins#index'

  scope module: 'web' do
    post 'auth/:provider', to: 'auth#request', as: :auth_request
    get 'auth/:provider/callback', to: 'auth#callback', as: :callback_auth
    get '/logout', to: 'auth#destroy', as: 'logout'
  end

  get 'up' => 'rails/health#show', as: :rails_health_check
  get 'profile', to: 'user#show'
  get 'admin', to: 'web/admin/bulletins#admin'

  get 'service-worker' => 'rails/pwa#service_worker', as: :pwa_service_worker
  get 'manifest' => 'rails/pwa#manifest', as: :pwa_manifest

  scope :web do
    resources :categories, controller: 'web/categories'
    resources :bulletins, controller: 'web/bulletins' do
      member do
        post :send_for_moderation
        post :archive
      end
    end
  end

  resources :users, controller: 'user'

  scope module: 'web'  do
    namespace :admin do
      resources :categories
      resources :bulletins do
        member do
          post :send_for_moderation
          post :publish
          post :reject
          post :archive
        end
        collection do
          get 'moderation'
        end
      end
    end
  end
end
