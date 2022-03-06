# == Schema Information
#
# Table name: movie_awards
#
#  id            :bigint           not null, primary key
#  delivery_year :integer
#  name          :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  award_id      :bigint           not null
#  movie_id      :bigint           not null
#
# Indexes
#
#  index_movie_awards_on_award_id  (award_id)
#  index_movie_awards_on_movie_id  (movie_id)
#
# Foreign Keys
#
#  fk_rails_...  (award_id => awards.id)
#  fk_rails_...  (movie_id => movies.id)
#
FactoryBot.define do
  factory :movie_award do
    name { Faker::Job.key_skill }
    delivery_year { Faker::Number.between(from: 1900, to: Time.zone.now.year) }
    association :movie
    association :award

    trait :invalid_long_name do
      name { Faker::Lorem.characters(number: 201) }
    end

    trait :invalid_short_name do
      name { Faker::Lorem.characters(number: 1) }
    end

    trait :invalid_big_delivery_year do
      delivery_year { Faker::Number.between(from: Time.zone.now.year + 1, to: 2100) }
    end

    trait :invalid_small_delivery_year do
      delivery_year { Faker::Number.between(from: 1800, to: 1899) }
    end
  end
end
