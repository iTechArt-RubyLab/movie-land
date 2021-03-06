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
        resources :movie_awards
        get 'movie-report', to: 'movie_reports#show'
      end

      resources :comments, only: %i[create update destroy] do
        resources :comments, only: %i[create update destroy]
      end

      resources :people do
        resources :comments, only: %i[create update destroy]
        get 'person-report', to: 'person_reports#show'
      end

      resources :roles, only: %i[index create update destroy] do
        resource :permissions, only: %i[show create update]
      end

      resources :tags, only: %i[index]

      resources :users, only: %i[index show update] do
        put 'access', to: 'access_user#update'
      end
      
      resources :view_lists, as: :my_view_list, path: 'my-view-list'
      resources :ratings, as: :my_ratings, path: 'my-ratings'

      resources :awards do
        resources :categories, only: %i[index create update destroy]
      end

      resources :search, only: [] do
        collection do
          get :index
        end
      end
      
      get 'movie-reports', to: 'movie_reports#index'
      get 'person-reports', to: 'person_reports#index'
    end
  end
end
