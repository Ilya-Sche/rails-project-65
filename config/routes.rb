# frozen_string_literal: true

Rails.application.routes.draw do
  get 'up' => 'rails/health#show', as: :rails_health_check

  get 'service-worker' => 'rails/pwa#service_worker', as: :pwa_service_worker
  get 'manifest' => 'rails/pwa#manifest', as: :pwa_manifest

  scope module: 'web' do
    root 'bulletins#index'
    post 'auth/:provider', to: 'auth#request', as: :auth_request
    get 'auth/:provider/callback', to: 'auth#callback', as: :callback_auth
    get '/logout', to: 'auth#destroy', as: 'logout'
    resource :profile, controller: 'users', action: 'show', as: 'profile'
    resources :bulletins do
      member do
        patch :send_for_moderation
        patch :archive
      end
    end
    namespace :admin do
      get '/', to: 'bulletins#admin'
      resources :categories
      resources :bulletins, only: %i[index show] do
        member do
          patch :publish
          patch :reject
          patch :archive
        end
        collection do
          get 'moderation'
        end
      end
    end
  end
end
