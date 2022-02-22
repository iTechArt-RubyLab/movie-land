# == Schema Information
#
# Table name: languages
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_languages_on_name  (name) UNIQUE
#
FactoryBot.define do
  factory :language do
    name { Faker::Nation.unique.language }

    trait :invalid_short_name do
      name { Faker::Lorem.characters(number: 1, min_alpha: 1) }
    end
    trait :invalid_long_name do
      name { Faker::Lorem.characters(number: 50, min_alpha: 50) }
    end
  end
end
