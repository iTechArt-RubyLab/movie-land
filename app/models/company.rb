class Company < ApplicationRecord
  has_many :companies_movies
  has_many :movies, through: :companies_movies, dependent: :destroy

  validates :name, length: { in: 2..200 }
end
