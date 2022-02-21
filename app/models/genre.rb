class Genre < ApplicationRecord
  has_many :genres_movies, dependent: :delete_all
  has_many :movies, through: :genres_movies, dependent: :destroy

  validates :name, length: { in: 2..50 }
end
