FactoryBot.define do
  factory :country do
    name { Faker::Address.country }

    trait :invalid_short_name do
      name { Faker::Lorem.characters(number: 2) }
    end

    trait :invalid_long_name do
      name { Faker::Lorem.characters(number: 150) }
    end
  end
end
