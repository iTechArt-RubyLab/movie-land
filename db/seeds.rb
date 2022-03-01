require 'factory_bot_rails'

FactoryBot.create_list(:country, 20)
FactoryBot.create_list(:company, 20)
FactoryBot.create_list(:genre, 20)
FactoryBot.create_list(:language, 20)
FactoryBot.create_list(:movie, 20)
FactoryBot.create_list(:person, 20)
FactoryBot.create_list(:rating, 20)
FactoryBot.create_list(:permission, 1, :admin)
FactoryBot.create_list(:permission, 1, :redactor)
FactoryBot.create_list(:permission, 1, :reviewer)
User.create(email: 'admin@example.com', password: '123456', password_confirmation: '123456',
            name: Faker::Name.first_name, surname: Faker::Name.last_name,
            username: Faker::Internet.unique.username(specifier: 8),
            birthday: Faker::Date.birthday(min_age: 18, max_age: 65),
            role: Role.first, confirmed_at: Time.zone.now)
User.create(email: 'redactor@example.com', password: '123456', password_confirmation: '123456',
            name: Faker::Name.first_name, surname: Faker::Name.last_name,
            username: Faker::Internet.unique.username(specifier: 8),
            birthday: Faker::Date.birthday(min_age: 18, max_age: 65),
            role: Role.second, confirmed_at: Time.zone.now)
User.create(email: 'reviewer@example.com', password: '123456', password_confirmation: '123456',
            name: Faker::Name.first_name, surname: Faker::Name.last_name,
            username: Faker::Internet.unique.username(specifier: 8),
            birthday: Faker::Date.birthday(min_age: 18, max_age: 65),
            role: Role.third, confirmed_at: Time.zone.now)
FactoryBot.create_list(:rating, 20)
