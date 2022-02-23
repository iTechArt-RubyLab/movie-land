# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  allow_password_change  :boolean          default(FALSE)
#  birthday               :date
#  confirmation_sent_at   :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  current_sign_in_at     :datetime
#  current_sign_in_ip     :string
#  email                  :string
#  encrypted_password     :string           default(""), not null
#  failed_attempts        :integer          default(0), not null
#  last_sign_in_at        :datetime
#  last_sign_in_ip        :string
#  locked_at              :datetime
#  name                   :string
#  provider               :string           default("email"), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  sign_in_count          :integer          default(0), not null
#  surname                :string
#  tokens                 :json
#  uid                    :string           default(""), not null
#  unconfirmed_email      :string
#  unlock_token           :string
#  username               :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  role_id                :bigint
#
# Indexes
#
#  index_users_on_confirmation_token    (confirmation_token) UNIQUE
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_role_id               (role_id)
#  index_users_on_uid_and_provider      (uid,provider) UNIQUE
#  index_users_on_unlock_token          (unlock_token) UNIQUE
#  index_users_on_username              (username) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (role_id => roles.id)
#
FactoryBot.define do
  factory :user do
    email { Faker::Internet.unique.email }
    password { 'testadmin' }
    password_confirmation { 'testadmin' }
    reset_password_token { nil }
    reset_password_sent_at { nil }
    remember_created_at { nil }
    sign_in_count { 1 }
    current_sign_in_at { '2015-02-06 14:02:10' }
    last_sign_in_at { '2015-02-06 14:02:10' }
    current_sign_in_ip { Faker::Internet.ip_v4_address }
    last_sign_in_ip { Faker::Internet.ip_v4_address }
    confirmed_at { Time.now.utc }
    name { Faker::Name.first_name }
    surname { Faker::Name.last_name }
    username { Faker::Lorem.unique.characters(number: 10) }
    birthday { '1990-01-28' }

    factory :confirmed_user do
      confirmed_at { Time.now.utc }
    end

    trait :invalid_short_name do
      name { Faker::Lorem.characters(number: 1) }
    end

    trait :invalid_long_name do
      name { Faker::Lorem.characters(number: 30) }
    end

    trait :invalid_short_surname do
      surname { Faker::Lorem.characters(number: 1) }
    end

    trait :invalid_long_surname do
      surname { Faker::Lorem.characters(number: 30) }
    end

    trait :invalid_short_username do
      username { Faker::Lorem.characters(number: 3) }
    end

    trait :invalid_long_username do
      username { Faker::Lorem.characters(number: 30) }
    end

    trait :admin do
      role { build :role, :admin }
    end

    trait :redactor do
      role { build :role, :redactor }
    end

    trait :reviewer do
      role { build :role, :reviewer }
    end
  end
end
