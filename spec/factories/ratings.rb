FactoryBot.define do
  factory :rating do
    body { Faker::Lorem.sentence(word_count: 10) }
    rating { Faker::Number.between(from: 1, to: 10) }
    association :user
    association :movie

    trait :invalid_short_body do
      body { Faker::Lorem.characters(number: 3) }
    end

    trait :invalid_long_body do
      body { Faker::Lorem.sentence(word_count: 50) }
    end

    trait :invalid_short_rating do
      rating { Faker::Number.between(from: -1, to: 0) }
    end

    trait :invalid_long_rating do
      rating { Faker::Number.between(from: 11, to: 15) }
    end
  end
end
