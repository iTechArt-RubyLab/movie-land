FactoryBot.define do
  factory :language do
    name { Faker::Nation.unique.language }

    trait :invalid_short_name do
      name { Faker::Lorem.characters(number: 1, min_alpha: 1) }
    end
    trait :invalid_long_name do
      name { Faker::Lorem.characters(number: 50, min_alpha: 50) }
    end
  end
end
