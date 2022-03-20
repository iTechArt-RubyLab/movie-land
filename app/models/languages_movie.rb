# == Schema Information
#
# Table name: languages_movies
#
#  language_id :bigint           not null
#  movie_id    :bigint           not null
#
# Indexes
#
#  index_languages_movies_on_language_id_and_movie_id  (language_id,movie_id) UNIQUE
#  index_languages_movies_on_movie_id_and_language_id  (movie_id,language_id) UNIQUE
#
class LanguagesMovie < ApplicationRecord
  belongs_to :movie
  belongs_to :language

  validates :movie_id, uniqueness: { scope: :language_id, message: 'This language already appointed' }
end
