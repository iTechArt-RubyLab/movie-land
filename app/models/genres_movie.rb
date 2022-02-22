class GenresMovie < ApplicationRecord
  belongs_to :movie
  belongs_to :genre
  validates :movie_id, uniqueness: { scope: :genre_id, message: 'This genre already appointed' }
end
