source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.2'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails', branch: 'main'
gem 'rails', '~> 6.1.4', '>= 6.1.4.4'
# Use postgresql as the database for Active Record
gem 'pg', '~> 1.1'
# Use Puma as the app server
gem 'puma', '~> 5.0'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
gem 'redis', '~> 4.6.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'
gem 'carrierwave'

gem 'devise'

gem 'devise_token_auth', '~> 1.2'

gem 'dotenv-rails'

gem 'mini_magick'

gem 'rswag-api'

gem 'rswag-ui'
# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'aasm', '~> 5.2'

gem 'bootsnap', '>= 1.4.4', require: false

gem 'factory_bot_rails', require: false

gem 'faker'

gem 'sidekiq'

gem 'sidekiq-cron'

gem 'pundit'

gem 'validate_url'

gem 'will_paginate'

gem 'strong_migrations'

gem 'themoviedb'

gem 'active_model_serializers', '~> 0.10.0'
# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem 'rack-cors'

gem 'elasticsearch-model', github: 'elastic/elasticsearch-rails', branch: 'main'

gem 'elasticsearch-rails', github: 'elastic/elasticsearch-rails', branch: 'main'

group :development, :test do
  gem 'brakeman'

  gem 'bundler-audit'

  gem 'factory_bot_rails'

  gem 'faker'

  gem 'pry-nav'

  gem 'pry-rails'

  gem 'rails-erd'

  gem 'rubocop', require: false

  gem 'rubocop-performance', require: false

  gem 'rubocop-rails', require: false

  gem 'rubocop-rspec', require: false
end

group :test do
  gem 'database_cleaner-active_record'

  gem 'elasticsearch-extensions'

  gem 'pundit-matchers'

  gem 'rspec-rails'

  gem 'rswag-specs'

  gem 'shoulda-matchers'

  gem 'simplecov', require: false
end

group :development do
  gem 'annotate'

  gem 'bullet'

  gem 'listen', '~> 3.3'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
