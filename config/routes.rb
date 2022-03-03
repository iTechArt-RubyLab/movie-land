Rails.application.routes.draw do
  root 'home#index'
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  mount_devise_token_auth_for 'User', at: 'auth'
  namespace :api do
    namespace :v1 do
      resources :countries
      resources :companies
      resources :genres
      resources :languages
      resources :movies
      resources :people
      resources :roles do
        resource :permissions
      end
      resources :tags
      resources :user do
        put 'access', to: 'access_user#update'
      end
      resources :view_lists, as: :my_view_list, path: 'my-view-list'
      resources :ratings, as: :my_ratings, path: 'my-ratings'
    end
  end
end
