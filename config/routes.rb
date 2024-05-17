# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :web do
    get 'profiles/show'
  end
  scope module: :web do
    root 'bulletins#index'

    resources :bulletins do
      member do
        patch :archive
        patch :to_moderate
      end
      resources :categories, only: %i[index new create edit update destroy]
    end

    namespace :admin do
      root 'bulletins#index', filter: :under_moderation

      resources :bulletins, only: %i[index], filter: :all do
        member do
          patch :publish
          patch :reject
          patch :archive
        end
      end
      resources :categories
    end

    resource :profile, only: %i[show]

    post :logout, to: 'auth#logout', as: :auth_logout
    post 'auth/:provider', to: 'auth#request', as: :auth_request
    get 'auth/:provider/callback', to: 'auth#callback', as: :callback_auth
  end
end
