# == Schema Information
#
# Table name: staff_types
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_staff_types_on_name  (name) UNIQUE
#
FactoryBot.define do
  factory :staff_type do
    name { Faker::Company.unique.profession }

    trait :invalid_short_name do
      name { Faker::Lorem.characters(number: 1, min_alpha: 1) }
    end
    trait :invalid_long_name do
      name { Faker::Lorem.characters(number: 35, min_alpha: 35) }
    end
  end
end
