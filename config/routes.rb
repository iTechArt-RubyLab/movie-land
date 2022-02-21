Rails.application.routes.draw do
  default_url_options :host => 'localhost:3000' # this code-line is for request tests
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
