FactoryBot.define do
  factory :award do
    name { Faker::Lorem.characters(number: 10) }
    nomination { Faker::Lorem.sentence(word_count: 3) }

    trait :invalid_long_name do
      name { Faker::Lorem.characters(number: 51) }
    end

    trait :invalid_short_name do
      name { Faker::Lorem.characters(number: 1) }
    end

    trait :invalid_long_nomination do
      nomination { Faker::Lorem.characters(number: 201) }
    end

    trait :invalid_short_nomination do
      nomination { Faker::Lorem.characters(number: 1) }
    end
  end
end
