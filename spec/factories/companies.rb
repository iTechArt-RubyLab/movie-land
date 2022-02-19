FactoryBot.define do
  factory :company do
    name { Faker::Company.name }

    trait :invalid_long_name do
      name { Faker::Lorem.characters(number: 201) }
    end

    trait :invalid_short_name do
      name { Faker::Lorem.characters(number: 1) }
    end
  end
end
