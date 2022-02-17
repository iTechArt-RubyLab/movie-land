FactoryBot.define do
  factory :company do
    title { Faker::Company.name }

    trait :invalid_long_title do
      title { Faker::Lorem.characters(number: 201) }
    end

    trait :invalid_short_title do
      title { Faker::Lorem.characters(number: 1) }
    end
  end
end
