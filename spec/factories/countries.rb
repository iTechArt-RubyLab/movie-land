FactoryBot.define do
  factory :country do
    title { Faker::Address.country }

    trait :invalid_short_title do
      title { Faker::Lorem.characters(number: 2) }
    end

    trait :invalid_long_title do
      title { Faker::Lorem.characters(number: 150) }
    end
  end
end
