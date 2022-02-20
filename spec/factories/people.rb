FactoryBot.define do
  factory :person do
    name { Faker::Name.first_name }
    surname { Faker::Name.last_name }
    birthday { Faker::Date.between(from: '1999-09-23', to: '2014-09-25') }
    deathday { Faker::Date.between(from: '2014-09-25', to: '2022-09-25') }
    association :country
    married { Faker::Boolean.boolean }
  end
  trait :invalid_short_name do
    name { Faker::Lorem.characters(number: 1, min_alpha: 1) }
  end
  trait :invalid_long_name do
    name { Faker::Lorem.characters(number: 130, min_alpha: 130) }
  end
  trait :invalid_short_surname do
    surname { Faker::Lorem.characters(number: 1, min_alpha: 1) }
  end
  trait :invalid_long_surname do
    surname { Faker::Lorem.characters(number: 130, min_alpha: 130) }
  end
end
