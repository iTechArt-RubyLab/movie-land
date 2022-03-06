# == Schema Information
#
# Table name: awards
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  country_id :bigint           not null
#
# Indexes
#
#  index_awards_on_country_id  (country_id)
#  index_awards_on_name        (name) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (country_id => countries.id)
#
FactoryBot.define do
  factory :award do
    name { Faker::Games::ElderScrolls.unique.city }
    association :country

    trait :invalid_long_name do
      name { Faker::Lorem.characters(number: 101) }
    end

    trait :invalid_short_name do
      name { Faker::Lorem.characters(number: 1) }
    end
  end
end
