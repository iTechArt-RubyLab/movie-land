class GenresMovie < ApplicationRecord
  belongs_to :movie
  belongs_to :genre
  # rubocop:disable Rails/UniqueValidationWithoutIndex
  validates :movie_id, uniqueness: { scope: :genre_id, message: 'This genre already appointed' }
  # rubocop:enable Rails/UniqueValidationWithoutIndex
end
