FactoryBot.define do
  factory :genre do
    name { Faker::Book.unique.genre }

    trait :invalid_long_name do
      name { Faker::Lorem.characters(number: 51) }
    end

    trait :invalid_short_name do
      name { Faker::Lorem.characters(number: 1) }
    end
  end
end
