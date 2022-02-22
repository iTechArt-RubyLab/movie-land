# == Schema Information
#
# Table name: companies
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_companies_on_name  (name) UNIQUE
#
FactoryBot.define do
  factory :company do
    name { Faker::Company.unique.name }

    trait :invalid_long_name do
      name { Faker::Lorem.characters(number: 201) }
    end

    trait :invalid_short_name do
      name { Faker::Lorem.characters(number: 1) }
    end
  end
end
