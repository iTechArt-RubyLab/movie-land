class Genre < ApplicationRecord
  has_many :genres_movies
  has_many :movies, through: :genres_movies, dependent: :destroy

  validates :name, length: { in: 2..50 }
end
