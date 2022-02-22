# == Schema Information
#
# Table name: countries
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_countries_on_name  (name) UNIQUE
#
FactoryBot.define do
  factory :country do
    name { Faker::Address.unique.country }

    trait :invalid_short_name do
      name { Faker::Lorem.characters(number: 2) }
    end

    trait :invalid_long_name do
      name { Faker::Lorem.characters(number: 150) }
    end
  end
end
