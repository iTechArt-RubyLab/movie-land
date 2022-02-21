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
    username { Faker::Internet.unique.username(specifier: 8) }
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
  end
end
