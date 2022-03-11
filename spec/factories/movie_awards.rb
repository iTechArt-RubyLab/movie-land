# == Schema Information
#
# Table name: movie_awards
#
#  id              :bigint           not null, primary key
#  delivery_year   :integer
#  nomination_type :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  category_id     :bigint           not null
#  movie_id        :bigint           not null
#
# Indexes
#
#  index_movie_awards_on_category_id  (category_id)
#  index_movie_awards_on_movie_id     (movie_id)
#
# Foreign Keys
#
#  fk_rails_...  (category_id => categories.id)
#  fk_rails_...  (movie_id => movies.id)
#
FactoryBot.define do
  factory :movie_award do
    delivery_year { Faker::Number.between(from: 1900, to: Time.zone.now.year) }
    nomination_type { %w[winner nominator].sample }
    association :movie
    association :category

    trait :invalid_big_delivery_year do
      delivery_year { Faker::Number.between(from: Time.zone.now.year + 1, to: 2100) }
    end

    trait :invalid_small_delivery_year do
      delivery_year { Faker::Number.between(from: 1800, to: 1899) }
    end
  end
end
