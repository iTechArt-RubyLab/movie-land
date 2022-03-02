require 'factory_bot_rails'

FactoryBot.create_list(:country, 20)
FactoryBot.create_list(:company, 20)
FactoryBot.create_list(:genre, 20)
FactoryBot.create_list(:language, 20)
FactoryBot.create_list(:movie, 20)
FactoryBot.create_list(:person, 20)
FactoryBot.create_list(:rating, 20)
FactoryBot.create(:permission, :admin)
FactoryBot.create(:permission, :redactor)
FactoryBot.create(:permission, :reviewer)
FactoryBot.create(:user, :admin, email: 'admin@example.com', password: '123456', password_confirmation: '123456')
FactoryBot.create(:user, :redactor, email: 'redactor@example.com', password: '123456', password_confirmation: '123456')
FactoryBot.create(:user, :reviewer, email: 'reviewer@example.com', password: '123456', password_confirmation: '123456')
FactoryBot.create_list(:rating, 20)
