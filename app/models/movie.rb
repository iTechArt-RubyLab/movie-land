class Movie < ApplicationRecord
  # rubocop:disable Rails/HasManyOrHasOneDependent
  has_many :companies_movies
  has_many :companies, through: :companies_movies, dependent: :destroy
  has_many :countries_movies
  has_many :countries, through: :countries_movies, dependent: :destroy
  has_many :genres_movies
  has_many :genres, through: :genres_movies, dependent: :destroy
  has_many :languages_movies
  has_many :languages, through: :languages_movies, dependent: :destroy
  has_many :movies_tags, dependent: :delete_all
  has_many :tags, through: :movies_tags, dependent: :destroy
  # rubocop:enable Rails/HasManyOrHasOneDependent

  validates :name, length: { in: 2..300 }
  validates :description, length: { in: 2..500 }
  validates :tagline, length: { in: 2..300 }
  validates :trailer, url: true
  validates :age_limit, numericality: { only_integer: true }, inclusion: { in: 1..100 }
  validates :budget, numericality: { only_integer: true, greater_than: 0 }
  validates :duration, numericality: { only_integer: true, greater_than: 1 }
end
