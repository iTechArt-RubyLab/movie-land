class Genre < ApplicationRecord
  # rubocop:disable Rails/HasManyOrHasOneDependent
  has_many :genres_movies
  # rubocop:enable Rails/HasManyOrHasOneDependent
  has_many :movies, through: :genres_movies, dependent: :destroy

  validates :name, length: { in: 2..50 }
end
