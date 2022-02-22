require 'factory_bot_rails'

FactoryBot.create_list(:country, 20)
FactoryBot.create_list(:company, 20)
FactoryBot.create_list(:genre, 20)
FactoryBot.create_list(:language, 20)
FactoryBot.create_list(:movie, 20)
FactoryBot.create_list(:person, 20)
admin_role = Role.create(name: 'admin', permission_attributes:
                        { can_lock_user: true, can_edit_role: true,
                          can_set_role: true, can_read: true, can_edit: true })
redactor_role = Role.create(name: 'redactor', permission_attributes:
                        { can_lock_user: false, can_edit_role: false,
                          can_set_role: false, can_read: true, can_edit: true })
reviewer_role = Role.create(name: 'reviewer', permission_attributes:
                        { can_lock_user: false, can_edit_role: false,
                          can_set_role: false, can_read: true, can_edit: false })

User.create(email: 'admin@example.com', password: '123456', password_confirmation: '123456',
            name: Faker::Name.first_name, surname: Faker::Name.last_name,
            username: Faker::Internet.unique.username(specifier: 8), birthday: Faker::Date.birthday(min_age: 18, max_age: 65),
            role_id: admin_role.id, confirmed_at: Time.zone.now)

User.create(email: 'redactor@example.com', password: '123456', password_confirmation: '123456',
            name: Faker::Name.first_name, surname: Faker::Name.last_name,
            username: Faker::Internet.unique.username(specifier: 8), birthday: Faker::Date.birthday(min_age: 18, max_age: 65),
            role_id: redactor_role.id)
User.create(email: 'reviewer@example.com', password: '123456', password_confirmation: '123456',
            name: Faker::Name.first_name, surname: Faker::Name.last_name,
            username: Faker::Internet.unique.username(specifier: 8), birthday: Faker::Date.birthday(min_age: 18, max_age: 65),
            role_id: reviewer_role.id)
FactoryBot.create_list(:user, 5)
FactoryBot.create_list(:rating, 20)
