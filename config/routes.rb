Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :countries
      resources :companies
      resources :genres
      resources :languages
      resources :movies
      resources :people
      resources :roles
      resources :permissions
      resources :tags
      mount_devise_token_auth_for 'User', at: 'auth'
      resources :user do
        put 'access', to: 'access_user#update'
      end
    end
  end
end
