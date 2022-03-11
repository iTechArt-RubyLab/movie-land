require 'sidekiq/web'
require 'sidekiq/cron/web'

Rails.application.routes.draw do
  root 'home#index'
  mount Sidekiq::Web => '/sidekiq'
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  mount_devise_token_auth_for 'User', at: 'auth'
  namespace :api do
    namespace :v1 do
      resources :countries, only: %i[index create update destroy]
      resources :companies, only: %i[index create update destroy]
      resources :genres, only: %i[index create update destroy]
      resources :languages, only: %i[index create update destroy]

      resources :movies do
        resources :comments, only: %i[create update destroy]
      end

      resources :comments, only: %i[create update destroy] do
        resources :comments, only: %i[create update destroy]
      end

      resources :people do
        resources :comments, only: %i[create update destroy]
      end

      resources :roles do
        resource :permissions, only: %i[show create update]
      end

      resources :tags, only: %i[index]

      resources :user, only: %i[index show update] do
        put 'access', to: 'access_user#update'
      end
      
      resources :view_lists, as: :my_view_list, path: 'my-view-list'
      resources :ratings, as: :my_ratings, path: 'my-ratings'
      resources :awards
    end
  end
  get 'search', to: 'home#search'
end
