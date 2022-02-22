# == Schema Information
#
# Table name: genres_movies
#
#  genre_id :bigint           not null
#  movie_id :bigint           not null
#
# Indexes
#
#  index_genres_movies_on_genre_id_and_movie_id  (genre_id,movie_id) UNIQUE
#  index_genres_movies_on_movie_id_and_genre_id  (movie_id,genre_id) UNIQUE
#
class GenresMovie < ApplicationRecord
  belongs_to :movie
  belongs_to :genre
  validates :movie_id, uniqueness: { scope: :genre_id, message: 'This genre already appointed' }
end
