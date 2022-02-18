FactoryBot.define do
  factory :season do
    title { Faker::Lorem.sentence(word_count: 3) }
    number { Faker::Number.between(from: 1, to: 100) }
    description { Faker::Lorem.sentence(word_count: 5) }
    trailer { Faker::Internet.url }
    associations :series

    trait :invalid_long_title do
      title { Faker::Lorem.characters(number: 301) }
    end

    trait :invalid_short_title do
      title { Faker::Lorem.characters(number: 1) }
    end

    trait :invalid_big_number do
      number { Faker::Number.between(from: 101, to: 200) }
    end

    trait :invalid_small_number do
      number { Faker::Number.negative }
    end

    trait :invalid_decimal_number do
      number { Faker::Number.decimal(l_digits: 2) }
    end

    trait :invalid_long_description do
      description { Faker::Lorem.characters(number: 501) }
    end

    trait :invalid_short_description do
      description { Faker::Lorem.characters(number: 1) }
    end

    trait :invalid_trailer_url do
      trailer { Faker::Lorem.characters(number: 5) }
    end
  end
end
