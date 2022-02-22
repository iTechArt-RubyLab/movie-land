FactoryBot.define do
  factory :tag do
    name { Faker::Emotion.unique.noun }

    trait :invalid_short_name do
      name { Faker::Lorem.characters(number: 1, min_alpha: 1) }
    end
    trait :invalid_long_name do
      name { Faker::Lorem.characters(number: 35, min_alpha: 35) }
    end
  end
end
