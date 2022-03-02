# == Schema Information
#
# Table name: ratings
#
#  id         :bigint           not null, primary key
#  rating     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  movie_id   :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_ratings_on_movie_id  (movie_id)
#  index_ratings_on_user_id   (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (movie_id => movies.id)
#  fk_rails_...  (user_id => users.id)
#
FactoryBot.define do
  factory :rating do
    rating { Faker::Number.between(from: 1, to: 10) }
    association :user
    association :movie

    trait :invalid_small_rating do
      rating { Faker::Number.between(from: -1, to: 0) }
    end

    trait :invalid_big_rating do
      rating { Faker::Number.between(from: 11, to: 15) }
    end
  end
end
