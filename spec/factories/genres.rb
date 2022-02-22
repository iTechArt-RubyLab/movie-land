# == Schema Information
#
# Table name: genres
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_genres_on_name  (name) UNIQUE
#
FactoryBot.define do
  factory :genre do
    name { Faker::Book.unique.genre }

    trait :invalid_long_name do
      name { Faker::Lorem.characters(number: 51) }
    end

    trait :invalid_short_name do
      name { Faker::Lorem.characters(number: 1) }
    end
  end
end
