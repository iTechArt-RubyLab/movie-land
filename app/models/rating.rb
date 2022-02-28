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
#  index_ratings_on_movie_id             (movie_id)
#  index_ratings_on_rating_and_movie_id  (rating,movie_id) UNIQUE
#  index_ratings_on_user_id              (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (movie_id => movies.id)
#  fk_rails_...  (user_id => users.id)
#
class Rating < ApplicationRecord
  belongs_to :user
  belongs_to :movie

  validates :rating, numericality: { only_integer: true }, inclusion: { in: 1..10 }
  validates :rating, uniqueness: { scope: :movie_id, message: 'This movie already rated by you.' }
end
