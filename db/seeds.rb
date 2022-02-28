require 'factory_bot_rails'

FactoryBot.create_list(:country, 20)
FactoryBot.create_list(:company, 20)
FactoryBot.create_list(:genre, 20)
FactoryBot.create_list(:language, 20)
FactoryBot.create_list(:movie, 20)
FactoryBot.create_list(:person, 20)
admin_role = Role.create(name: 'admin', permission_attributes:
                        { can_lock_user: true, can_edit_role: true,
                          can_set_role: true, can_edit_movie_and_person: true, can_read_movie_and_person: true,
                          can_read_entities: true, can_edit_entities: true })
redactor_role = Role.create(name: 'redactor', permission_attributes:
                        { can_lock_user: false, can_edit_role: false,
                          can_set_role: false, can_edit_movie_and_person: true, can_read_movie_and_person: true,
                          can_read_entities: true, can_edit_entities: true })
reviewer_role = Role.create(name: 'reviewer', permission_attributes:
                        { can_lock_user: false, can_edit_role: false,
                          can_set_role: false, can_edit_movie_and_person: false, can_read_movie_and_person: true,
                          can_read_entities: false, can_edit_entities: false })

User.create(email: 'admin@example.com', password: '123456', password_confirmation: '123456',
            name: Faker::Name.first_name, surname: Faker::Name.last_name,
            username: Faker::Internet.unique.username(specifier: 8), birthday: Faker::Date.birthday(min_age: 18, max_age: 65),
            role_id: admin_role.id, confirmed_at: Time.zone.now)

User.create(email: 'redactor@example.com', password: '123456', password_confirmation: '123456',
            name: Faker::Name.first_name, surname: Faker::Name.last_name,
            username: Faker::Internet.unique.username(specifier: 8), birthday: Faker::Date.birthday(min_age: 18, max_age: 65),
            role_id: redactor_role.id, confirmed_at: Time.zone.now)
User.create(email: 'reviewer@example.com', password: '123456', password_confirmation: '123456',
            name: Faker::Name.first_name, surname: Faker::Name.last_name,
            username: Faker::Internet.unique.username(specifier: 8), birthday: Faker::Date.birthday(min_age: 18, max_age: 65),
            role_id: reviewer_role.id, confirmed_at: Time.zone.now)
FactoryBot.create_list(:rating, 20)
