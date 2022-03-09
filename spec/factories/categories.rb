# == Schema Information
#
# Table name: categories
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  award_id   :bigint           not null
#
# Indexes
#
#  index_categories_on_award_id  (award_id)
#
# Foreign Keys
#
#  fk_rails_...  (award_id => awards.id)
#
FactoryBot.define do
  factory :category do
    name { Faker::Job.key_skill }
    association :award

    trait :invalid_long_name do
      name { Faker::Lorem.characters(number: 201) }
    end

    trait :invalid_short_name do
      name { Faker::Lorem.characters(number: 1) }
    end
  end
end
