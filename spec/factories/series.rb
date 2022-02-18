FactoryBot.define do
  factory :series do
    title { Faker::Lorem.sentence(word_count: 3) }
    description { Faker::Lorem.sentence(word_count: 5) }
    trailer { Faker::Internet.url }

    trait :invalid_short_title do
      title { Faker::Lorem.characters(number: 1) }
    end

    trait :invalid_long_title do
      title { Faker::Lorem.characters(number: 301) }
    end

    trait :invalid_short_description do
      description { Faker::Lorem.characters(number: 1) }
    end

    trait :invalid_long_description do
      description { Faker::Lorem.characters(number: 501) }
    end

    trait :invalid_trailer_url do
      trailer { Faker::Lorem.characters(number: 5) }
    end
  end
end
