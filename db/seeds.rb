require 'factory_bot_rails'

FactoryBot.create(:permission, :admin)
FactoryBot.create(:permission, :redactor)
FactoryBot.create(:permission, :reviewer)
FactoryBot.create(:user, :admin, email: 'admin@example.com', password: '123456', password_confirmation: '123456')
FactoryBot.create(:user, :redactor, email: 'redactor@example.com', password: '123456', password_confirmation: '123456')
FactoryBot.create(:user, :reviewer, email: 'reviewer@example.com', password: '123456', password_confirmation: '123456')
FactoryBot.create_list(:user, 30, :admin)
FactoryBot.create_list(:user, 30, :redactor)
FactoryBot.create_list(:user, 30, :reviewer)
