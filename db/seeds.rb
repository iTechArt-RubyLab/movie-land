require 'factory_bot_rails'

FactoryBot.create_list(:country, 20)
FactoryBot.create_list(:company, 20)
FactoryBot.create_list(:genre, 20)
FactoryBot.create_list(:language, 20)
FactoryBot.create_list(:movie, 20)
FactoryBot.create_list(:person, 20)
Role.create(name: 'admin', permission_attributes: { can_lock_user: true, can_edit_role: true, can_set_role: true, can_read: true, can_edit: true })
Role.create(name: 'redactor', permission_attributes: { can_lock_user: false, can_edit_role: false, can_set_role: false, can_read: true, can_edit: true })
Role.create(name: 'reviewer', permission_attributes: { can_lock_user: false, can_edit_role: false, can_set_role: false, can_read: true, can_edit: false })
FactoryBot.create_list(:tag, 20)
