Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'
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
      resources :user do
        put 'access', to: 'access_user#update'
      end
    end
  end
end
