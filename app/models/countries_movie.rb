# == Schema Information
#
# Table name: countries_movies
#
#  country_id :bigint           not null
#  movie_id   :bigint           not null
#
# Indexes
#
#  index_countries_movies_on_country_id_and_movie_id  (country_id,movie_id) UNIQUE
#  index_countries_movies_on_movie_id_and_country_id  (movie_id,country_id) UNIQUE
#
class CountriesMovie < ApplicationRecord
  belongs_to :movie
  belongs_to :country

  validates :movie_id, uniqueness: { scope: :country_id, message: 'This country already appointed' }
end
