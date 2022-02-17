FactoryBot.define do
  factory :category do
    name { Faker::Lorem.characters(number: 15, min_alpha: 15) }

    trait :invalid_short_name do
      name { Faker::Lorem.characters(number: 1, min_alpha: 1) }
    end
    trait :invalid_long_name do
      name { Faker::Lorem.characters(number: 50, min_alpha: 50) }
    end
  end
end
