FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    name { Faker::Name.name }
    surname { Faker::Name.last_name }
    username { Faker::Internet.unique.username }
    birthday { Faker::Date.between(from: '2014-09-23', to: '2014-09-25') }
    password { '123456' }
    password_confirmation { '123456' }
    reset_password_token { nil }
    reset_password_sent_at { nil }
    remember_created_at { nil }

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
      username { Faker::Lorem.characters(number: 2) }
    end

    trait :invalid_long_username do
      username { Faker::Lorem.characters(number: 2) }
    end
  end
end
