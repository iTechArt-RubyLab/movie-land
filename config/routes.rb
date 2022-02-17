Rails.application.routes.draw do
  resources :languages
  resources :awards
  resources :categories
  resources :tags
  resources :genres
  resources :countries
  resources :companies
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
